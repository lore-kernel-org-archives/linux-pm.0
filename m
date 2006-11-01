From: Stefan Seyfried <seife@suse.de>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 14:50:26 +0100
Message-ID: <20061101135026.GA25751@suse.de>
References: <20061029231358.GI27968@stusta.de> <20061101030126.GE27968@stusta.de> <200610312215.44454.len.brown@intel.com> <200611010611.30445.earny@net4u.de> <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, linux-pm@osdl.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Hugh Dickins <hugh@veritas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Martin Lorenz <martin@lorenz.eu.org>, Adrian Bunk <bunk@stusta.de>, Ernst Herzberg <earny@net4u.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 31, 2006 at 09:26:12PM -0800, Linus Torvalds wrote:
> (Or it might not. Sometimes the patch that triggers changes really do=
esn't=20
> seem to have anything to do with anything, and it literally was just =
a=20
> latent bug that just happened to be exposed by something that had not=
hing=20
> to do with anything at all but perhaps timing.

Especially when "booting on AC works, but on battery it doesn't", (or t=
he
other way round), looking at timing problems seems sane to me.
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=
=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
