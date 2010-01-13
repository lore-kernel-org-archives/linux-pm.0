From: Jakob Lell <jakob@cs.tu-berlin.de>
Subject: Re: [Suspend-devel] Serious bug in s2disk may cause
 filesystem corruption when suspending to swap file
Date: Thu, 14 Jan 2010 00:27:01 +0100
Message-ID: <4B4E56C5.20507__47219.8232230314$1263425314$gmane$org@cs.tu-berlin.de>
References: <4B4D1DBA.6020402@cs.tu-berlin.de> <201001132224.35173.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010000010404080202030504"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001132224.35173.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel@lists.sourceforge.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------010000010404080202030504
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael!

Rafael J. Wysocki wrote:
> The most recent version of the suspend package, located at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-utils.git
>
> has all of these problems fixed.
>   
I've taken a short look at this code and it isn't completely fixed. The 
value shift in the functions reset_signature(), mark_signature(), 
open_resume_dev() and read_image() is still only calculated as a 32 bit 
value:

off64_t shift = (resume_offset + 1) * page_size - size;

Since resume_offset and page_size are both 32 bit values, the c compiler 
will do the multiplication as a 32 bit value and in the end convert the 
result to 64 bit. To solve the problem, one of the values must be 
converted to 64 bit before the multiplication. I'd suggest using this:

off64_t shift = ( (off64_t) resume_offset + 1) * page_size - size;

I've attached a test program which calculates the value in both ways and 
prints the result. Here is the output it generates:
> SHIFT=1578110966
> SHIFT=409600004086

I'd really appreciate if you could release a new version of the package. 
Most users and linux distributors prefer to get the latest stable 
version of software instead of downloading a (possibly unstable) 
development version from a repository. The latest released version (0.8) 
is two years old now and it probably contains many more bugs which have 
been fixed since then.

Regards
Jakob


--------------010000010404080202030504
Content-Type: text/x-csrc;
 name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test.c"

#define _LARGEFILE64_SOURCE
#include <sys/types.h>
#include <unistd.h>


int main(){
  int resume_offset = 100000000;
  int page_size = 4096;
  int size = 10;
  off64_t shift = (resume_offset + 1) * page_size - size;
  printf("SHIFT=%lld\n",shift);
  shift = ( (off64_t) resume_offset + 1) * page_size - size;
  printf("SHIFT=%lld\n",shift);
}

--------------010000010404080202030504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010000010404080202030504--
