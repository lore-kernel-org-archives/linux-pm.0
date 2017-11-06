From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFT][PATCH v2 1/2] PM / domains: Rework governor code to be more consistent
Date: Mon, 6 Nov 2017 15:38:01 +0100
Message-ID: <CAPDyKFoOcmHU6pE4QQnpZE8qPAq4p2Fepy43a272gHYSUwDoow@mail.gmail.com>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan> <2520927.XkLgALY3I0@aspire.rjw.lan>
 <1780873.Ca3tjQj9XB@aspire.rjw.lan> <CAPDyKFox_5XN1bV1rG_DJvADnpQLqBQcJFDamkEvpRXRMP7mag@mail.gmail.com>
 <CAJZ5v0jmeqxZyws_hS8T8pZdHK2p3kzzAA4-jaJw9+v9gv1DRQ@mail.gmail.com>
 <CAPDyKFpCZov7nJVijToJ7k_YJb_CKAeScpRC5KhrZ8qdiDFSVg@mail.gmail.com> <CAJZ5v0ifOC1S4LDpD0nRQ0XxiS=WdLRUJ89y45drhG0Szkju0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0ifOC1S4LDpD0nRQ0XxiS=WdLRUJ89y45drhG0Szkju0Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tero Kristo <t-kristo@ti.com>, Reinette Chatre <reinette.chatre@intel.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>
List-Id: linux-pm@vger.kernel.org

[...]

>>>
>>> So I guess I'll simply evaluate dev_pm_qos_read_value(dev) if
>>> subsys_data or subsys_data->domain_data is not there.
>>
>> Yes.
>>
>> However, if it returns -1, what value should you pick? 0?
>
> Without the second patch, -1 will just mean "no suspend", so the
> parent cannot be suspended too, but that should just work AFAICS
> (effective_constraint_ns may be -1 too at that point, if present).

I am fine with whatever policy you pick.

However, I suspect it may be more tricky respecting a -1 (no suspend),
because this means dev_update_qos_constraint() then may continue to
return a negative value, which you changed the caller,
default_suspend_ok(), to not cope with.

Anyway, let me look at the code one you posted a new version. :-)

[...]

Kind regards
Uffe
