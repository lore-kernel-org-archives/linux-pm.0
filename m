From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 5/9] PM: suspend_block: Add debugfs file
Date: Sun, 25 Apr 2010 12:53:01 -0700
Message-ID: <4BD49D9D.7020004__19641.4615413689$1272225697$gmane$org@oracle.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
	<1271984938-13920-4-git-send-email-arve@android.com>
	<1271984938-13920-5-git-send-email-arve@android.com>
	<1271984938-13920-6-git-send-email-arve@android.com>
	<20100423135853.478af057.randy.dunlap@oracle.com>
	<20100425181517.GA22676@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100425181517.GA22676@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 04/25/10 11:15, Greg KH wrote:
> On Fri, Apr 23, 2010 at 01:58:53PM -0700, Randy Dunlap wrote:
>> On Thu, 22 Apr 2010 18:08:54 -0700 Arve Hj?nnev?g wrote:
>>
>>> Report active and inactive suspend blockers in
>>> /sys/kernel/debug/suspend_blockers.
>>
>>
>> This looks more like user interface information than it does debug information.
>> If that's correct, it shouldn't be in debugfs.
> 
> It's debug-like information, and has more than one value per file, so
> debugfs seems like the proper place for it.  I have no objection to it
> going there.

I have no objection if it really is debug info, but I'm not convinced
of that yet.

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
