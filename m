From: =?ISO-8859-1?Q?Aur=E9lien_Francillon?= <aurel@naurel.org>
Subject: Re: 2.6.14 suspend fails with "Strange,
	firmware/dell_r not stopped"
Date: Thu, 10 Nov 2005 04:42:16 +0100
Message-ID: <4372C198.8010506@naurel.org>
References: <436F3609.2050907@naurel.org> <20051109214807.GC12459@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051109214807.GC12459@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@osdl.org, abhay_salunke@dell.com
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Hi!
>=20
>=20
>>suspending to ram or disk fails on 2.6.14, with
>>CONFIG_DELL_RBU=3Dy
>>
>>in logs i have :
>>
>>Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> stopping tasks failed (1 tasks remaining)
>>Restarting tasks...<6> Strange, firmware/dell_r not stopped
>> done
>>
>>with CONFIG_DELL_RBU=3Dn everything is fine
>=20
>=20
> Apparently, DELL_RBU runs some kernel thread. Find a place in that
> kernel thread where it is okay to sleep, and add try_to_freeze()
> there.
>=20
> (Or forward this to dell rbu people.)
> 							Pavel

Thanks a lot for your quick answer and for the hint,
after some investigation, it looks like it's not directly due to the
dell_rbu driver but to firmware_class, when using request_firmware_nowait=
 :

dell_rbu
 -> request_firmware_nowait
  -> request_firmware_work_func (new kernel thread)
   -> _request_firmware
    -> wait_for_completion

and there is no timeout when _request_firmware is called with hotplug
disabled. I have added try_to_freeze() in the loop of
wait_for_completion near the call to schedule but it didn't help...
It's maybe unsafe to suspend while loading firmware this case  should
also be handled?
Another issue is that the rbu driver updates the bios, once it is
configured with the new binary it's probably unsafe to suspend because
the kernel will resume on a different bios, i don't know much of
the kernel/bios interactions but i guess it could be a buggy situation...

cheers,
Aur=E9lien
