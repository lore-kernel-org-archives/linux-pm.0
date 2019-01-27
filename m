From: Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [RFC PATCH] drivers core: cpu: add hotplug callback to update
 cpu_dev state to resumed
Date: Sun, 27 Jan 2019 14:57:37 +0100
Message-ID: <CAH3KO=0kUewNu20G82RxVFmZXJ2amuxFwXjkrHMCGJix75LuCw@mail.gmail.com>
References: <20190125130701.GA855@vmlxhi-102.adit-jv.com> <20190125150906.27614-1-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125150906.27614-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>, Steve Longerbeam <steve_longerbeam@mentor.com>, Joshua Frkuska <joshua_frkuska@mentor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu Rosca <rosca.eugeniu@gmail.com>
List-Id: linux-pm@vger.kernel.org

FWIW the "cache: parent cpuN should not be sleeping" warnings no longer
appear during s2ram procedure on R-Car H3-ES20 Salvator-X with this patch.
The kernel version is v5.0-rc3-241-g7c2614bf7a1f.
The test procedure is:

root@salvator-x:~# modprobe i2c-dev
root@salvator-x:~# i2cset -f -y 7 0x30 0x20 0x0F
root@salvator-x:~# echo deep > /sys/power/mem_sleep
root@salvator-x:~# echo mem > /sys/power/state

Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
