From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 0/7] Add initial support for DA9150 Charger & Fuel-Gauge
 IC
Date: Sun, 08 Mar 2015 11:27:13 +0000
Message-ID: <54FC3211.2020501@kernel.org>
References: <cover.1424267009.git.Adam.Thomson.Opensource@diasemi.com> <20150225203307.GC13695@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150225203307.GC13695@earth>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 25/02/15 20:33, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Feb 18, 2015 at 02:08:19PM +0000, Adam Thomson wrote:
>> This patch set adds initial support for the Dialog DA9150 Integrated Charger &
>> Fuel-Gauge IC. The device also provides GPIO and GPADC functionality.
>>
>> In this patch set the following is provided:
>>  - MFD Core support and DT bindings documentation.
>>  - IIO GPADC support and DT bindings documentation.
>>  - Power Supply Charger support and DT bindings documentation.
>>  - Update to MAINTAINERS file to add DA9150 files to Dialog support list.
>>
>> To keep patch submission from being too large, support for GPIO and Fuel-Gauge
>> will come after initial support patches are accepted.
>>
>> This patch set is baselined against the v3.19 kernel version.
> 
> I pulled in patches 3-7 into battery-2.6.git (patch 1 was already
> applied by Lee in 4.0-rc1 and patch 2 can simply be pulled in by
> Lee).
> 
> Jonathan: I have prepared an immutable branch "da9150-charger-fuelgauge"
> based on 4.0-rc1, which contains the IIO bits, so that you can pull them
> in, too:
> 
> git://git.infradead.org/battery-2.6.git da9150-charger-fuelgauge
I'll grab these only if I get patches on top of them in this cycle. 
Things get a little fiddly otherwise with my pull requests to Greg
and I'm lazy ;)

Thanks for sorting this Sebastian.

Good to see this series all sorted out at last!

Jonathan
> 
> --Sebastian
> 
