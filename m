From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
        <jerome.debretagne@gmail.com>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on
 recent Dell laptops
Date: Mon, 12 Jun 2017 22:35:50 +0200
Message-ID: <CA+kEDGEXEYEV+tGnswvHsFmOX5W_GAYPTYxk0YUUt0D1pdr92A@mail.gmail.com>
References: <CA+kEDGHNOQboMy34=EmH6zVSgtdVz1afOz5hwx5HBKshWhackA@mail.gmail.com>
 <31f516ad46d74225a5d6324c5fd24751@ausx13mpc124.AMER.DELL.COM>
 <CA+kEDGFUuSC1CpCEgOT+HMTrDa-r1y59kM9-CYn0PSgtuKaG5Q@mail.gmail.com>
 <343a8430fb144adf8d65ef9d0b2bfd40@ausx13mpc124.AMER.DELL.COM>
 <CA+kEDGFVgmXf_B=qHfhWS1HCD+Ei6KSp_rSJBOGYtNZVkm+MeA@mail.gmail.com>
 <24ac3bb8850c4b7a8fa9c0c2d9e3cbc4@ausx13mpc124.AMER.DELL.COM>
 <CA+kEDGHev9XYQr=BEVZ8od+nX_cQ637eY0cF81_v3auQZvBKRQ@mail.gmail.com>
 <CAJZ5v0haCFYW8FRXtuLREFscLq_QRbyhnGf39u0P7xzUaGYVVQ@mail.gmail.com> <88366b425cce41358ae8f88e43f3d201@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <88366b425cce41358ae8f88e43f3d201@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

> I don't see HEBC in the ASL for the 7275.  It would be good to provide
> this information across both of the BIOS versions (working and non-workin=
g).
>
> As well as what
>         status =3D acpi_evaluate_integer(handle, "BTNC", NULL, &button_ca=
p);
> evaluates as on both too.

I'll provide both BTNC and HEBC log results to compare, with both BIOS
versions, a bit later today.

> Since this platform shipped with Win 8.1 initially rather than Win10,
> It's possible 5 button array was not part of the INT33D5 spec at that tim=
e
> and wasn't used by the Windows Intel HID filter driver.
>
> My suspicion:
> Win 8.1 didn't support 5 button array definition yet and those events tha=
t
> are normally part of 5 button array (as detected by bit 17) were coming
> across as regular HID event codes (like you were seeing 0xCE and 0xCF
> unknown events from debug log when OS was running).

That was my assumption also, since my earlier 3-liner patch was doing
this exactly: trying to wake up on a regular 0xCE event. And it did work.

J=C3=A9rome
