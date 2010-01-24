From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/2] PM / Runtime: Add sysfs switch for
 disabling device run-time PM (rev. 2)
Date: Sun, 24 Jan 2010 07:56:38 -0800
Message-ID: <59qes3i0orxy6yfyqhf7q34x.1264348598355__1957.69553906775$1264348640$gmane$org@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Greg@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org



"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

>On Saturday 23 January 2010, Alan Stern wrote:
>> On Sat, 23 Jan 2010, Rafael J. Wysocki wrote:
>> 
>> > Hmm, OK.
>> > 
>> > Of course, if the driver decides to leave disable_depth > 0, the user still
>> > won't be able to do anything about that, but if I understand correctly, you
>> > want drivers to have the option to use pm_runtime_forbid() initially, right
>> > after pm_runtime_enable(), so that the user space can turn the runtime PM
>> > on if desired via sysfs.
>> > 
>> > That makes sense.  I have a usage case for that myself. :-)
>> > 
>> > Updated patch is appended.
>> 
>> It looks good.
>> 
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>
>Thanks!
>
>Rafael
>
