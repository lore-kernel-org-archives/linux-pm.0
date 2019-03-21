From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3 2/2] [WIP] tools/power turbostat: Also read package
 power on AMD F17h (Zen)
Date: Wed, 20 Mar 2019 23:09:26 -0400
Message-ID: <CAJvTdKkCeVWQu8eCBf5wLV7==z_A4LctgayEN+7+tFjyd3LBLA@mail.gmail.com>
References: <20180817163442.10065-1-calvin.walton@kepstin.ca>
 <20180817163442.10065-3-calvin.walton@kepstin.ca> <CAJvTdKmXSQyY-Jdv7OkseHEE-76oDPLeJ8v8ShApDRKqWsukSQ@mail.gmail.com>
 <d45d021c5546a301cf1c53d6b6d8c83ebd802a57.camel@kepstin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d45d021c5546a301cf1c53d6b6d8c83ebd802a57.camel@kepstin.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Calvin Walton <calvin.walton@kepstin.ca>
Cc: Linux PM list <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> (I previously wrote that this would be easier to test with the patch
> applied, because the package power is reported with the -Dump option,
> but I'm not sure that's actually the case - the value might still only
> be collected once per package?)

Right -- we'd have to move it to a per-core or per-CPU data structure
to capture it on a finer granularity than per package.

Of course, if you want to see if you get different values on the cpus,
you can always dump the raw values from each cpu using rdmsr(1).

Unfortunately, I don't have that AMD hardware -- somebody with an
interest in it can test it out.

thanks,
Len Brown, Intel Open Source Technology Center
