From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] Add LTC2941/LTC2943 Battery Gauge Driver
Date: Wed, 11 Feb 2015 12:21:52 +0100
Message-ID: <54DB3B50.7020902@topic.nl>
References: <20141027163842.GB20765@earth.universe> <1414479912-3545-1-git-send-email-mike.looijmans@topic.nl> <20150122022426.GP13715@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150122022426.GP13715@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
List-Id: linux-pm@vger.kernel.org

=EF=BB=BFOn 22-01-15 03:24, Sebastian Reichel wrote:
> Hi,
>
> On Tue, Oct 28, 2014 at 08:05:12AM +0100, Mike Looijmans wrote:
>> Both the LTC2941 and LTC2943 measure battery capacity.
>> The LTC2943 is compatible with the LTC2941, it adds voltage and
>> temperature monitoring, and uses a slightly different conversion
>> formula for the charge counter.
>>
>> To avoid confusion with e.g. the LTC2945, the driver is called
>> LTC2941 instead of LTC294X.
>
> Applied with .owner field removed.
>
> -- Sebastian
>

Hello,

We found a bug in the LTC2941 driver (typo, it says "58" in the formula=
 which=20
should be "85") just yesterday. I couldn't find it in mainline yet, I'l=
l post=20
a patch to fix it.




Met vriendelijke groet / kind regards,

Mike Looijmans
System Expert


TOPIC Embedded Systems
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: (+31) (0) 499 33 69 79
Telefax:  (+31) (0) 499 33 69 70
E-mail: mike.looijmans@topic.nl
Website: www.topic.nl

Please consider the environment before printing this e-mail

Visit us at Embedded World 2015 Nuernberg, 24.02.2015 till 26.02.2015, =
Hall 1, stand number 136.
https://www.embedded-world.de/de/ausstellerprodukte/?focus=3Dedb3exhibi=
tor&focus2=3D14017667&focus3=3Dembwld15&highlight=3Dtopic
