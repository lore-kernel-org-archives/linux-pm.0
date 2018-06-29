From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v3 0/4] Add devicetree functionality to w1 busses and
 ds2760
Date: Fri, 29 Jun 2018 19:35:13 +0200
Message-ID: <48c3d0fd-7a31-3531-044c-3cbd307771c8@zonque.org>
References: <20180629173137.12690-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180629173137.12690-1-daniel@zonque.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu
Cc: sre@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr
List-Id: linux-pm@vger.kernel.org

On Friday, June 29, 2018 07:31 PM, Daniel Mack wrote:
> This patch set contains four small patches that bring devicetree
> functionality to w1 bus masters and slaves in general. As an example,
> the DS2760 driver is made aware of devicetree nodes as an example.
> Other drivers can easily be ported later.
> 
> W1 masters scan their bus in order to discover slave devices. Once
> one is found, a driver matching the family of the device is instanciated
> which handles it.
> 
> All that's needed for now is a call to of_find_matching_node() when
> a slave device is attached, so the corresponding of_node pointer is
> set.
> 
> The series also contains a patch that merges the w1 slave driver for the
> DS2760 battery monitor into its only user, the ds2760 supply driver.
> The indirection with two drivers never had any benefit, and here is
> a good opportunity to clean this up.
> 
> Patch #1 adds some DT bindings documentation
> Patch #2 adds the call to of_find_matching_node()
> Patch #3 merges the w1 slave and the supply driver for ds2760
> Patch #4 makes the ds2760 supply driver aware of DT environments
> 
> This works fine on a PXA3xx based board with a battery attached to
> the w1-gpio bus master controller.

Sorry, I messed up the patch statistics in the cover letter. Here is the 
correct version:


  .../bindings/power/supply/maxim,ds2760.txt    |  29 ++
  .../devicetree/bindings/w1/w1-gpio.txt        |   6 +
  Documentation/devicetree/bindings/w1/w1.txt   |  18 +
  drivers/power/supply/Kconfig                  |   2 +-
  drivers/power/supply/ds2760_battery.c         | 351 +++++++++++++-----
  drivers/w1/slaves/Kconfig                     |  12 -
  drivers/w1/slaves/Makefile                    |   1 -
  drivers/w1/slaves/w1_ds2760.c                 | 175 ---------
  drivers/w1/slaves/w1_ds2760.h                 |  59 ---
  drivers/w1/w1.c                               |   3 +
  include/linux/w1.h                            |   2 +
  11 files changed, 320 insertions(+), 338 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
  create mode 100644 Documentation/devicetree/bindings/w1/w1.txt
  delete mode 100644 drivers/w1/slaves/w1_ds2760.c
  delete mode 100644 drivers/w1/slaves/w1_ds2760.h
