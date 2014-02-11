From: Bastien Traverse <bastien.traverse@gmail.com>
Subject: Re: 3.12: ethernet controller missing after resuming from suspend
 to RAM
Date: Tue, 11 Feb 2014 19:14:25 +0100
Message-ID: <52FA6881.4030602@gmail.com>
References: <52F2CC7B.80406@gmail.com> <2087423.Qy7HQIx1X6@vostro.rjw.lan> <52F7CC8B.1020209@gmail.com> <2182978.C0zdYi5cqX@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2182978.C0zdYi5cqX@al>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Wu <lekensteyn@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, francis.moro@gmail.com, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Le 09/02/2014 23:07, Peter Wu a =E9crit :
> I think this is relevant. See also my test with 3.13.2 and different
> kernel configs[1]. A workaround that triggers a scan was also posted[=
2].
>=20
> Peter
>=20
>  [1]: http://lkml.org/lkml/2014/2/8/264
>  [2]: http://lkml.org/lkml/2014/2/7/809

Thanks, I can confirm that triggering a rescan by issuing

  sudo tee /sys/devices/pci0000:00/0000:00:1c.1/rescan <<<1

made the device reappear on my system (of course I had to adapt the
command to match PCI Bridge number). That's a handy workaround, it
avoids restarting each time.

As I've never compiled a kernel so far I think I'll leave the
configuration tweaks for another time :)

Cheers
