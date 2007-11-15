From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Fri, 16 Nov 2007 00:59:41 +0100
Message-ID: <473CDD6D.8080008__42580.6165127598$1195171930$gmane$org@gmail.com>
References: <20071113175906.497a1a6a.akpm@linux-foundation.org>
	<473B5987.60904@gmail.com> <200711142248.59547.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711142248.59547.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 11/14/2007 10:48 PM, Rafael J. Wysocki wrote:
> On Wednesday, 14 of November 2007, Jiri Slaby wrote:
>> On 11/14/2007 02:59 AM, Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.24-rc2/2.6.24-rc2-mm1/
>> Doesn't suspend for me (neither broken-out-2007-11-13-04-14 did) on x86_64.
>> echo mem >/sys/power/state
>> causes shut down of disk(s) and blinking cursor on 1,1 position.
>> The last working was 2.6.23-rc8-mm2. I haven't tested
>> 2.6.23-mm1, since it didn't work for me.
> 
> Does the current mainline work?

Yes.

The offending -mm patch is
gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch

2.6.24-rc2-mm1 minus it works just fine; PROVE_LOCKING shows nothing new when
the patch is applied.

regards,
-- 
Jiri Slaby (jirislaby@gmail.com)
Faculty of Informatics, Masaryk University
