From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 58/76] idle, x86: Allow off-lined CPU to enter deeper C
 states
Date: Mon, 2 Apr 2012 13:45:57 -0400
Message-ID: <20120402174557.GA9446@phenom.dumpdata.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
 <1333102459-23750-1-git-send-email-lenb@kernel.org>
 <1a022e3f1be11730bd8747b1af96a0274bf6356e.1333101989.git.len.brown@intel.com>
 <CA+8MBbLROfbyfAGZ0xn1tZVHsndeTUNrn=-gHhsfzkocBLh=iQ@mail.gmail.com>
 <CA+8MBbJnrhKmy5f_pbL8Ogi1ihM-51hfqCDY5gUQ1hkvw7p22Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+8MBbJnrhKmy5f_pbL8Ogi1ihM-51hfqCDY5gUQ1hkvw7p22Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tony Luck <tony.luck@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@amd.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 02, 2012 at 10:25:27AM -0700, Tony Luck wrote:
> >> + =A0 =A0 =A0 while (1) {
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cx->entry_method =3D=3D ACPI_CST=
ATE_HALT)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt();
>=20
> What's the intent here?  I think that I can just set up a function po=
inter
> named "halt" on ia64 and point it to my cpu_halt() function (which lo=
oks
> for the deepest C-state, and then calls PAL to enter it. Is that equi=
valent
> to what the x86 "halt()" function does?

Or use the appropiate safe_halt() which should work on IA64.

>=20
> -Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
