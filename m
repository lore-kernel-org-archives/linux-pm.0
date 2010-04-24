From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 5/9] PM: suspend_block: Add debugfs file
Date: Fri, 23 Apr 2010 21:24:06 -0700
Message-ID: <4BD27266.8070900@oracle.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>	
	<1271984938-13920-2-git-send-email-arve@android.com>	
	<1271984938-13920-3-git-send-email-arve@android.com>	
	<1271984938-13920-4-git-send-email-arve@android.com>	
	<1271984938-13920-5-git-send-email-arve@android.com>	
	<1271984938-13920-6-git-send-email-arve@android.com>	
	<20100423135853.478af057.randy.dunlap@oracle.com>
	<n2rd6200be21004232023hf138c65dia5b378825124933d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <n2rd6200be21004232023hf138c65dia5b378825124933d@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/23/10 20:23, Arve Hj=F8nnev=E5g wrote:
> 2010/4/23 Randy Dunlap <randy.dunlap@oracle.com>:
>> On Thu, 22 Apr 2010 18:08:54 -0700 Arve Hj=F8nnev=E5g wrote:
>>
>>> Report active and inactive suspend blockers in
>>> /sys/kernel/debug/suspend_blockers.
>>
>>
>> This looks more like user interface information than it does debug infor=
mation.
>> If that's correct, it shouldn't be in debugfs.
> =

> Where should it be? It is not allowed in sysfs, and procfs does not
> appear to be open to new files.

Why is it not allowed in sysfs?  due to more than one value per file
or something else?

I don't think that procfs is closed to new files, but you may have to
justify why it should be used.

-- =

~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
