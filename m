From: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Fri, 10 Feb 2006 09:06:43 +0100
Message-ID: <20060210080643.GA14763@suse.de>
References: <20060208125753.GA25562@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060208125753.GA25562@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 08, 2006 at 12:57:53PM +0000, Matthew Garrett wrote:
> The included patch adds support for power management methods to regis=
ter=20
> callbacks in order to allow drivers to check if the system is on AC o=
r=20
> not. Following patches add support to ACPI and APM. Feedback welcome.

Ok. Maybe i am not seeing the point. But why do we need this in the ker=
nel?
Can't we handles this easily in userspace?
--=20
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write.=
"
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Co=
hen
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
