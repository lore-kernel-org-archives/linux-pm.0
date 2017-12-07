From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] PM / devfreq: Fix potential NULL pointer dereference in
 governor_store
Date: Thu, 07 Dec 2017 17:57:44 -0600
Message-ID: <20171207175744.Horde.9NnT_zmVm82lkttN8KTbaNG@gator4166.hostgator.com>
References: <20171206202015.GA15636@embeddedor.com>
 <CGME20171206202020epcas3p4fe9a9fb5346f2d413199ed71d1d0f19f@epcms1p4>
 <20171207024144epcms1p4d7e1a981c7c307190a85e8c35174d983@epcms1p4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207024144epcms1p4d7e1a981c7c307190a85e8c35174d983@epcms1p4>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Quoting MyungJoo Ham <myungjoo.ham@samsung.com>:

>> df->governor is being dereferenced before it is null checked,
>> hence there is a potential null pointer dereference.
>>
>> Notice that df->governor is being null checked at line 1004:
>> if (df->governor) {, which implies it might be null.
>>
>> Fix this by null checking df->governor before dereferencing it.
>>
>> Addresses-Coverity-ID: 1401988 ("Dereference before null check")
>> Fixes: bcf23c79c4e4 ("PM / devfreq: Fix available_governor sysfs")
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>

Thank you, MyungJoo

--
Gustavo A. R. Silva
