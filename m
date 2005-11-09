From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH 0/2] swsusp: improve freeing of
	memory
Date: Wed, 9 Nov 2005 22:04:02 +0100
Message-ID: <20051109210402.GA12461@elf.ucw.cz>
References: <200511082355.43984.rjw@sisk.pl> <20051109143040.GA1852@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============91130692016180015=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051109143040.GA1852@elf.ucw.cz>
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
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============91130692016180015==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > The patches are on top of 2.6.14-mm1 with the three additional patches of mine
> > that went to Andrew after 2.6.14-mm1.  For your convenience the whole
> > series of patches is available at:
> > 
> > http://www.sisk.pl/kernel/patches/2.6.14-mm1/
> > 
> > as:
> > 
> > swsusp-reduce-code-duplication.patch
> > swsusp-improve-relocation.patch
> > swsusp-rework-swsusp_suspend.patch
> > swsusp-introduce-swap-map.patch
> > swsusp-improve-freeing-memory.patch
> 
> I got
> 
>   CC      kernel/power/snapshot.o
...
> kernel/power/snapshot.c:49: error: for each function it appears in.)
> 
> I tried turning off HIGMEM, that got me rid of snapshot.c:49
> problem. I killed nr_copy_pages from power.h. I tried suspending
> twice, and it seems to work okay. I guess they are ready for lkml
> testing...

I put it under a bit heavier test (attached), and it survive for a
hour. Looks good.

								Pavel
#!/bin/bash
SW3=false
if $SW3 ; then
    swapoff /dev/hda1
    cat /dev/zero | head -c 4096 > /dev/hda1
else
    swapon -a
    echo -n reboot > /sys/power/disk
fi


(
    while true ; do
	echo "Suspending machine" 
	if $SW3; then
	    /tmp/swsusp /dev/hda1 -s -b
	else
	    echo -n disk > /sys/power/state
	fi

	sleep 30
	done
) &
cd /data/l
cp -a linux-good linux-fscktest
cd /data/l/linux-fscktest
make clean
time make -j 10

-- 
Thanks, Sharp!

--===============91130692016180015==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============91130692016180015==--
