From: Kukjin Kim <kgene@kernel.org>
Subject: Re: [PATCH v6 00/18] thermal: exynos: Thermal code rework to use
 device tree
Date: Fri, 27 Feb 2015 06:21:25 +0900
Message-ID: <54EF8E55.5050803@kernel.org>
References: <1421666462-7606-1-git-send-email-l.majewski@samsung.com> <1422015010-11918-1-git-send-email-l.majewski@samsung.com> <20150124214955.GA14443@developer.hsd1.ca.comcast.net> <54CAC3A2.5060804@kernel.org> <20150223111338.11ca4b6c@amdc2363> <039101d04f5a$80147660$803d6320$@kernel.org> <20150226165659.1a37de79@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150226165659.1a37de79@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, 'Eduardo Valentin' <edubezval@gmail.com>, 'Zhang Rui' <rui.zhang@intel.com>, 'Linux PM list' <linux-pm@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Lukasz Majewski' <l.majewski@majess.pl>, 'Amit Daniel Kachhap' <amit.daniel@samsung.com>, 'Abhilash Kesavan' <kesavan.abhilash@gmail.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Chanwoo Choi' <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 02/27/15 00:56, Lukasz Majewski wrote:
> Hi Kukjin,
> 
>> Lukasz Majewski wrote:
>>>
>>> Hi Kukjin, Eduardo
>>>
>> Hi,

[...]

>>> Kukjin, could you add missing DTS files and send this to upstream.
>>>
>> Unfortunately, I couldn't take the DT changes in Samsung tree at that
>> time because of missing header file and it causes build error. Now I
>> can pick them into Samsung tree but I'm not sure it can be sent to
>> upstream during this -rc...
>>
>> Eduardo, Lukasz,
>> Do you guys think the DT changes are really fixes for 4.0?
> 
> I've created following repository with DTS files:
> 
> https://github.com/lmajewski/linux-samsung-thermal.git
> 
> Branch: devel.
> 
> On top of the v4.0-rc1 tag you will find all necessary patches for
> fixing thermal regression at Samsung Exynos boards.
> 
> I hope, that organizing all patches in a separate repository will
> facilitate and speed up the inclusion process.

I already did :-) If any problems on the branch
(v4.0-samsung-dt-tmu-hdmi) in my tree, please kindly let me know.

Thanks,
Kukjin
