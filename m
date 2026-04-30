Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF024279F8;
	Thu, 30 Apr 2026 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560135; cv=none; b=g6fBQ7qxQllBbotuI1tKMgFRxR4uAfYwFEUe352mIOA8lmxL7IVjKSD/NKADLOVwhBnFysdLkaeTz3twT6c++ocigh3hkys9edePCsqraZHT9QI0YHbMJ/2SmO6528ftu+wiWzYbam8TRzMY3IaNu/MPQAhJ91kIIgVb7HOV+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560135; c=relaxed/simple;
	bh=iVMt6GfKbVRnrE1e85Lw0uA8Sc/dpXog7Tdk/VLb3KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0/udoZeq0kSfZUk4lvYpHTxAwXeUptyErJZXTP8H0lqNM9tP0+h7kaFevz7B4v+hmozNTCBHB9yMnhH7KUhN7yc2Crn7KwK/Oe0DaDXKK2LC9KndGqtYt2NdUnuHScSTJdaNAOErDd/0lyFfCVDeu2PtGfkhY773RTdcXw9xg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVYPozic; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVYPozic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA1EC2BCB3;
	Thu, 30 Apr 2026 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777560134;
	bh=iVMt6GfKbVRnrE1e85Lw0uA8Sc/dpXog7Tdk/VLb3KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVYPozicjCLC8Lb4M7/JBJNPIN159RBTJXKJLw3yEyeNJukETOG17v6BqQtSHlkIy
	 XABHy+nXiz4mYy/8yzjYdw07pVnabYGy3hQju5wdcjTj9vZwU7Js+pj4wr8FL5JVQ/
	 Ct6HDvqhmlVB0rDzjLjCKzFRikmN36BPjVtU2XG8pxEeSTnZhx3PtTbTiOanFLQoy/
	 0WLTne9+Q3VTkHktS+viz7bxgbv8QUwnqmIUNrqV9z8kLXrz7ZlUQOblxr61SaXZNY
	 yJ75Am43eWuebhKoRXdvSM1OY/Dd+TFtXbBPg8khngiRg6TfngiWAHxW6muyyLALEb
	 oSkiJv0GxUneg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 LKML <linux-kernel@vger.kernel.org>,
 Wysocki Rafael J <rafael.j.wysocki@intel.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Subject:
 Re: Pressing the power button causes the device to freeze completely
 (schedutil involved)
Date: Thu, 30 Apr 2026 16:42:09 +0200
Message-ID: <12909238.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0ixuF=AQf0_VcPH=4jo5X-HbEB3WvJAnk8_fZes+bjyLg@mail.gmail.com>
References:
 <12879883.O9o76ZdvQC@rafael.j.wysocki>
 <CAGAxtY3h4sEphqKL-jiSn4p0NT9mdZtOFrVxW7CDo22XdL56iw@mail.gmail.com>
 <CAJZ5v0ixuF=AQf0_VcPH=4jo5X-HbEB3WvJAnk8_fZes+bjyLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thursday, April 30, 2026 3:57:41 PM CEST Rafael J. Wysocki wrote:
> On Thu, Apr 30, 2026 at 1:41=E2=80=AFPM Evgeny Sagatov <evgeny.sagatov@gm=
ail.com> wrote:
> >
> > I noticed that for powersave mode, I'm getting the following values:
>=20
> I guess you mean with the powersave governor.
>=20
> > cat /proc/cpuinfo | grep MHz
> > cpu MHz         : 2798.689
> > cpu MHz         : 1999.659
> > cpu MHz         : 1999.797
> > cpu MHz         : 2741.103
> > Also, there's now no difference in the single-core benchmark between
> > schedutil, ondemand, powersave and performance modes. The benchmark
> > always gives a very high result.
> > This wasn't the case before; the modes had different performance levels.
>=20
> I would expect schedutil, ondemand and performance to give similar
> scores, but for powersave I would expect the score to be lower.
>=20
> With the same patch applied, can you please switch over to powersave,
> reset the stats and then capture the output of
>=20
> grep -r . /sys/devices/system/cpu/cpufreq/
>=20
> Also, I'd still like to see the output of
>=20
> grep . /sys/firmware/acpi/interrupts/sci*

Additionally, please remove all of the debug patches sent so far, apply
the one below and send a dmesg boot log.

I want to check if all of the CPUs use the same control values when
they write to the frequency scaling control register.

=2D--
 drivers/cpufreq/acpi-cpufreq.c |   12 +++++++++---
 drivers/cpufreq/cpufreq.c      |    1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

=2D-- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -887,9 +887,14 @@ static int acpi_cpufreq_cpu_init(struct
 		 * unknown and not detectable via IO ports.
 		 */
 		policy->cur =3D acpi_cpufreq_guess_freq(data, policy->cpu);
+		pr_info("CPU%u: Using I/O space for frequency scaling\n", cpu);
+		pr_info("CPU%u: frequency scaling control address: %llu, bit width: %u\n=
",
+			cpu, perf->control_register.address,
+			perf->control_register.bit_width);
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
 		acpi_cpufreq_driver.get =3D get_cur_freq_on_cpu;
+		pr_info("CPU%u: Using FFH for frequency scaling\n", cpu);
 		break;
 	default:
 		break;
@@ -898,13 +903,14 @@ static int acpi_cpufreq_cpu_init(struct
 	/* notify BIOS that we exist */
 	acpi_processor_notify_smm(THIS_MODULE);
=20
=2D	pr_debug("CPU%u - ACPI performance management activated.\n", cpu);
+	pr_info("CPU%u - ACPI performance management activated.\n", cpu);
 	for (i =3D 0; i < perf->state_count; i++)
=2D		pr_debug("     %cP%d: %d MHz, %d mW, %d uS\n",
+		pr_info("     %cP%d: %d MHz, %d mW, %d uS, %u\n",
 			(i =3D=3D perf->state ? '*' : ' '), i,
 			(u32) perf->states[i].core_frequency,
 			(u32) perf->states[i].power,
=2D			(u32) perf->states[i].transition_latency);
+			(u32) perf->states[i].transition_latency,
+			(u32) perf->states[i].control);
=20
 	/*
 	 * the first call to ->target() should result in us actually
=2D-- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -473,6 +473,7 @@ void cpufreq_enable_fast_switch(struct c
 	if (cpufreq_fast_switch_count >=3D 0) {
 		cpufreq_fast_switch_count++;
 		policy->fast_switch_enabled =3D true;
+		pr_info("CPU%u: Fast frequency switching enabled\n", policy->cpu);
 	} else {
 		pr_warn("CPU%u: Fast frequency switching not enabled\n",
 			policy->cpu);




