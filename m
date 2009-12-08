From: Victor Lowther <victor.lowther@gmail.com>
Subject: Re: [PATCH 1/1] Add /sys/power/last_state support
Date: Mon, 7 Dec 2009 18:17:36 -0600
Message-ID: <7E0E364A-4AC2-4D3B-B7A0-61DC970C9254@gmail.com>
References: <3c192bd846cc4337d9999c6cd66b649232d9561c.1260074113.git.victor.lowther@gmail.com>
	<200912072241.28017.rjw@sisk.pl>
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912072241.28017.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Dec 7, 2009, at 3:41 PM, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Sunday 06 December 2009, you wrote:
>> Hi, I have a completly unsolicited patch that I figured I should  
>> run past you
>> before proceeding to embarrass myself on lkml, as there does not  
>> seem to be
>> a linux kernel related mailing list more dedicated to power  
>> management.
>
> There is a pm list, <linux-pm@lists.linux-foundation.org>.  Please  
> post patches
> to this list in the future rather than to me directly, because I  
> have rather
> limited patch-reviewing capacity.

Yes, I found it shortly after sending you the patch.

>
>> This patch just adds /sys/power/last_state, which will make my job  
>> making
>> pm-utils more robust in the face of suspend or hibernate failure a  
>> little
>> easier.
>>
>> last_state will contain the last suspend state the kernel  
>> successfully
>> resumed from.  This sysfs interface was added so that userspace tools
>> (such as pm-utils) can determine whether the last requested power  
>> management
>> operation succeeded or failed without having to listen to uevents  
>> (a tricky
>> proposition when you are written in shell script), or parse the  
>> kernel event
>> log (annoying when most of the time things will succeed anyways).
>
> What exactly do you need the previous state for?

So that pm-utils could see whether or not suspend/hibernate worked or  
just returned due to a failure of some sort.

>
> Can't you just use the error code returned by "echo mem > /sys/power/ 
> state"?

I can, now that I know about it - I did not see anything about error  
codes when scanning the documentation.

>
> Rafael
>
