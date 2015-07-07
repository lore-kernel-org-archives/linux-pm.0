From: Julian Andres Klode <jak@jak-linux.org>
Subject: sysfs charge thresholds for ThinkPads (and possibly others),
 preparation for second try
Date: Tue, 7 Jul 2015 23:07:28 +0200
Message-ID: <20150707210728.GA7524@jak-x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: evgeni@debian.org
List-Id: linux-pm@vger.kernel.org

Hi everyone (Thinkpad-ACPI, ACPI, and Power supply maintainers),

some might know that I presented a patch set adding support for
charge thresholds to thinkpad_acpi about 1.5 years ago. 

Back then, one of the major rejections was that the functionality
for setting charge thresholds should be integrated into the
power supply stack somehow. I did not know who to contact back
then, but know I re-read MAINTAINERS and found all your addresses,
so I give it a second try.

One issue with just integrating it in the current battery
directories would be that ThinkPads are able to set charge
thresholds for batteries that are currently not inserted.

Back then I wrote:
> The next step is to integrate this properly with power supply
> and/or acpi battery. One way would be to add additional power
> supply properties and then add get/set_property() pointers to
> the acpi battery which it can fall back to if it does not support
> a requested property (and we would locate the ACPI battery and
> set those pointers to new thinkpad_acpi functions).

If you, the ACPI and power supply people, have any preferred
way (or any idea at all how) to proceed, that would be useful,
so I don't start working on it again, and then somebody does
not like it.

Regards,

Julian

CCing evgeni@debian.org who keeps pushing me to follow up
on this - thanks :)

-- 
Julian Andres Klode  - Debian Developer, Ubuntu Member

See http://wiki.debian.org/JulianAndresKlode and http://jak-linux.org/.

Be friendly, do not top-post, and follow RFC 1855 "Netiquette".
    - If you don't I might ignore you.
