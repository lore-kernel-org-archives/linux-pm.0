From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
        <jerome.debretagne@gmail.com>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on
 recent Dell laptops
Date: Tue, 13 Jun 2017 00:38:49 +0200
Message-ID: <CA+kEDGEM7PmMTonmoFKoJrMU6hxLh_zauLRt_fq=2v_Jxo35NQ@mail.gmail.com>
References: <CA+kEDGHNOQboMy34=EmH6zVSgtdVz1afOz5hwx5HBKshWhackA@mail.gmail.com>
 <31f516ad46d74225a5d6324c5fd24751@ausx13mpc124.AMER.DELL.COM>
 <CA+kEDGFUuSC1CpCEgOT+HMTrDa-r1y59kM9-CYn0PSgtuKaG5Q@mail.gmail.com>
 <343a8430fb144adf8d65ef9d0b2bfd40@ausx13mpc124.AMER.DELL.COM>
 <CA+kEDGFVgmXf_B=qHfhWS1HCD+Ei6KSp_rSJBOGYtNZVkm+MeA@mail.gmail.com>
 <24ac3bb8850c4b7a8fa9c0c2d9e3cbc4@ausx13mpc124.AMER.DELL.COM>
 <CA+kEDGHev9XYQr=BEVZ8od+nX_cQ637eY0cF81_v3auQZvBKRQ@mail.gmail.com>
 <CAJZ5v0haCFYW8FRXtuLREFscLq_QRbyhnGf39u0P7xzUaGYVVQ@mail.gmail.com>
 <88366b425cce41358ae8f88e43f3d201@ausx13mpc120.AMER.DELL.COM> <CA+kEDGEXEYEV+tGnswvHsFmOX5W_GAYPTYxk0YUUt0D1pdr92A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CA+kEDGEXEYEV+tGnswvHsFmOX5W_GAYPTYxk0YUUt0D1pdr92A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

2017-06-12 22:35 GMT+02:00 J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@=
gmail.com>:
>> I don't see HEBC in the ASL for the 7275.  It would be good to provide
>> this information across both of the BIOS versions (working and non-worki=
ng).
>>
>> As well as what
>>         status =3D acpi_evaluate_integer(handle, "BTNC", NULL, &button_c=
ap);
>> evaluates as on both too.
>
> I'll provide both BTNC and HEBC log results to compare, with both BIOS
> versions, a bit later today.

Here are both requested logs, with BIOS 1.1.31 first:

* right after status =3D acpi_evaluate_integer(handle, "HEBC", NULL, &event=
_cap);
[    4.167874] intel-hid INT33D5:00: intel_hid_probe: event_cap =3D
0xffff9bfe71bdc410
[    4.167875] intel-hid INT33D5:00: intel_hid_probe: status =3D 5

* right after status =3D acpi_evaluate_integer(handle, "BTNC", NULL, &butto=
n_cap);
=3D> No log output for that one


And with BIOS 1.1.20 then:

* right after status =3D acpi_evaluate_integer(handle, "HEBC", NULL, &event=
_cap);
[    4.172543] intel-hid INT33D5:00: intel_hid_probe: event_cap =3D
0xffff8d1f70950810
[    4.172545] intel-hid INT33D5:00: intel_hid_probe: status =3D 5

* right after status =3D acpi_evaluate_integer(handle, "BTNC", NULL, &butto=
n_cap);
=3D> No log output for that one


Status =3D 5 confirms the assumption that HEBC is not found in both cases.
I guess the absence of logs for BTNC is more surprising, isn't it?

J=C3=A9rome
