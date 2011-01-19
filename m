From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: Resume from Memory very slow on 2.6.37+
Date: Wed, 19 Jan 2011 22:13:13 +0800
Message-ID: <AANLkTimf3B=z1DCA2q+yi-ccyAJwmjkB_g8EP=ZTehmn__5637.08129707283$1295446502$gmane$org@mail.gmail.com>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com>
	<201101182120.16835.rjw@sisk.pl>
	<AANLkTikay6g5rOyDnv_ocz49GvUcQN+OkrusrbcRPB0K@mail.gmail.com>
	<201101190238.18529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101190238.18529.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 19, 2011 at 9:38 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, January 19, 2011, Jeff Chua wrote:
>> On Wed, Jan 19, 2011 at 4:20 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > Please apply the appended patch (without the previous one) and post a =
dmesg
>> > log containing a suspend-resume cycle with the delay. =A0I wonder wher=
e exactly
>> > the delay occurs.
>> > + =A0 =A0 =A0 pr_info("%s: synchronize_rcu()\n", __func__);
>> > =A0 =A0 =A0 =A0synchronize_rcu();
>> > + =A0 =A0 =A0 pr_info("%s: iounmap(%p), physaddr: %llx, size: %u\n", _=
_func__,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 map->virt, map->phys, map->size);
>>
>> Rafael,
>>
>> The 30 seconds is due to this ...
>>
>> PM: Syncing filesystems ... done.
>> Freezing user space processes ... _memory: synchronize_rcu()
>> acpi_os_unmap_memory: iounmap(ffffc90001c22000), physaddr: bb398000, siz=
e: 4096
>> acpi_os_unmap_memory: synchronize_rcu()
>> acpi_os_unmap_memory: iounmap(ffffc90001c26000), physaddr: bb399000, siz=
e: 4096
00), physaddr: bb79e000, size: 4096
>> Restarting tasks ... done.
>>
>> After this, I see my X windows.
>
> Are you able to say whether the synchronize_rcu() or the iounmap() calls =
block?

It's "synchronize_rcu()" that's causing the slow down. Removing it
solves the problem.

Does synchronize_rcu() triggers the limiting update rate as described
in Documentation/RCU/whatisRCU.txt?

        In addition, the synchronize_rcu() API has the nice property
        of automatically limiting update rate should grace periods
        be delayed.  This property results in system resilience in face
        of denial-of-service attacks.


Thanks,
Jeff
