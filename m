From: Laurent Riffard <laurent.riffard@free.fr>
Subject: Re: BUG while suspending to swap on LVM
Date: Tue, 15 Aug 2006 14:36:47 +0200
Message-ID: <44E1BFDF.4000105@free.fr>
References: <44E0A995.50806@free.fr> <44E0EA33.7080801@free.fr>
	<200608142337.56843.rjw@sisk.pl> <200608142353.38527.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200608142353.38527.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Le 14.08.2006 23:53, Rafael J. Wysocki a =E9crit :
> On Monday 14 August 2006 23:37, Rafael J. Wysocki wrote:
>> On Monday 14 August 2006 23:25, Laurent Riffard wrote:
>>> Le 14.08.2006 22:50, Rafael J. Wysocki a =E9crit :
>>>> On Monday 14 August 2006 22:03, Laurent Riffard wrote:
>>>>> Le 14.08.2006 21:16, Rafael J. Wysocki a =E9crit :
>>>>>> On Monday 14 August 2006 19:48, Laurent Riffard wrote:
>>>>>>> Le 14.08.2006 19:30, Rafael J. Wysocki a =E9crit :
> ]--snip--[
>>> I tested with only 1 swap device online: /dev/mapper/vglinux1-lvswap: =

>>> same BUG happened with 2.6.18-rc4-mm1 patched.
>> Of course the patch doesn't matter if there's only one swap online. :-)
>>
>> I have no ideas for now and I think some debug patches will be needed to=
 find
>> out what's up.
> =

> Could you please try to revert the following patches (in this order):
> =

> swsusp-use-memory-bitmaps-during-resume.patch
> swsusp-introduce-memory-bitmaps.patch
> swsusp-struct-snapshot_handle-cleanup.patch
> swsusp-clean-up-browsing-of-pfns.patch
> swsusp-read-speedup-cleanup-2.patch
> swsusp-read-speedup-cleanup.patch
> swsusp-read-speedup-fix.patch
> swsusp-read-speedup.patch
> swsusp-read-timer.patch
> swsusp-write-speedup.patch
> swsusp-write-timer.patch
> =

> from 2.6.18-rc4-mm1 and see if that helps?
> =

> Rafael

The bad guy is swsusp-read-speedup.patch. (I did a bisection on the
-mm kernel).

-- =

laurent
