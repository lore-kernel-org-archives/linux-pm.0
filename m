From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 58/76] idle, x86: Allow off-lined CPU to enter deeper C states
Date: Mon, 2 Apr 2012 09:13:46 -0700
Message-ID: <CA+8MBbLROfbyfAGZ0xn1tZVHsndeTUNrn=-gHhsfzkocBLh=iQ@mail.gmail.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
	<1333102459-23750-1-git-send-email-lenb@kernel.org>
	<1a022e3f1be11730bd8747b1af96a0274bf6356e.1333101989.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1a022e3f1be11730bd8747b1af96a0274bf6356e.1333101989.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@amd.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 30, 2012 at 3:14 AM, Len Brown <lenb@kernel.org> wrote:
> From: Boris Ostrovsky <boris.ostrovsky@amd.com>

This bit breaks ia64 build:

> +
> +/**
> + * acpi_idle_play_dead - enters an ACPI state for long-term idle (i.=
e. off-lining)
> + * @dev: the target CPU
> + * @index: the index of suggested state
> + */
> +static int acpi_idle_play_dead(struct cpuidle_device *dev, int index=
)
> +{
> + =A0 =A0 =A0 struct cpuidle_state_usage *state_usage =3D &dev->state=
s_usage[index];
> + =A0 =A0 =A0 struct acpi_processor_cx *cx =3D cpuidle_get_statedata(=
state_usage);
> +
> + =A0 =A0 =A0 ACPI_FLUSH_CPU_CACHE();
> +
> + =A0 =A0 =A0 while (1) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cx->entry_method =3D=3D ACPI_CSTATE=
_HALT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (cx->entry_method =3D=3D ACPI_C=
STATE_SYSTEMIO) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inb(cx->address);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* See comment in acpi_=
idle_do_entry() */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inl(acpi_gbl_FADT.xpm_t=
imer_block.address);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }

drivers/acpi/processor_idle.c: In function 'acpi_idle_play_dead':
drivers/acpi/processor_idle.c:789: error: implicit declaration of
function 'halt'

So the initial compiler complaint is just about "halt()" - but those "i=
nb()" and
"inl()" parts don't look very ia64 compatible either.

-Tony
