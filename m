From: jonghwa3.lee@samsung.com
Subject: Re: [RFC 2/4] power: core: Add generic interface to get battery
 specification.
Date: Mon, 09 Mar 2015 20:24:30 +0900
Message-ID: <54FD82EE.7070408@samsung.com>
References: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
 <1425638007-9411-3-git-send-email-jenny.tc@intel.com>
 <1425640566.2197.2.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1425640566.2197.2.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>, Jenny TC <jenny.tc@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, myungjoo.ham@gmail.com, Pallala Ramakrishna <ramakrishna.pallala@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,
2015=EB=85=84 03=EC=9B=94 06=EC=9D=BC 20:16=EC=97=90 Oliver Neukum =EC=9D=
=B4(=EA=B0=80) =EC=93=B4 =EA=B8=80:
>> +
>> +	/* Check if same data is existed */
>> +	list_for_each_entry(battery, &psy_battery_info_list, entry)
>> +		if (!strcmp(battery->info->name, info->name))
>> +			return -EEXIST;
>> +
>> +	battery =3D kzalloc(sizeof(*battery), GFP_KERNEL);
>=20
> That is a race condition. If you check for duplication, you'll
> need a lock.
>=20

Yes, you`re right. I`ll apply it.

Thanks,
Jonghwa
