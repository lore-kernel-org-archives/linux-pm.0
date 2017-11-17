From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: Re: [PATCH v11 02/10] i2c: i2c-smbus: Move i2c_setup_smbus_alert from
 i2c-smbus to i2c-core-smbus
Date: Fri, 17 Nov 2017 20:15:59 +0800
Message-ID: <c5a9309b-a595-c663-1e39-f83ed08c8c07@electromag.com.au>
References: <1503567070-115646-1-git-send-email-preid@electromag.com.au>
 <1503567070-115646-3-git-send-email-preid@electromag.com.au>
 <20171029154408.vmjkpj7ybqyrj3ke@ninjato>
 <1397131b-c22d-9872-dbe0-9b691553cb9e@electromag.com.au>
 <20171106213646.2h3zsitnlablblli@ninjato>
 <2eaccb51-62cf-b764-d313-84008c6c8f87@electromag.com.au>
 <20171107072254.s43mwpyplx3hdkyo@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171107072254.s43mwpyplx3hdkyo@ninjato>
Content-Language: en-AU
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 7/11/2017 15:22, Wolfram Sang wrote:
> 
>> I was just thinking that all that's in the file now is smbus-alert code.
>> The other smbus (host notify) code was moved to i2c-core
>> So maybe i2c-core-smbus-alert and as you say use makefile to include it.
> 
> Aaaah, i2c-core-smbus-alert.c. Yes, that probably makes sense. I was
> wondering about i2c-smbus-alert.c (without -core)...
> 
>> I've tried this and it seems to work for the various combinations.
>> I'll wait a bit for Jean to offer an opinion.
> 
> Well, if you have code already, can you post it as RFC and CC Jean?
> It usually is easier to talk over code, even if it is not perfect yet...
> 

Yes will do. Was hoping to clean it up into some incremental patches and post this week.
But it looks like next week now.

-- 
Regards
Phil Reid
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
