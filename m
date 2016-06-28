From: Chris Lapa <chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org>
Subject: Re: [PATCH v5 0/7] max8903: Add device tree support and misc fixes
Date: Wed, 29 Jun 2016 09:05:59 +1000
Message-ID: <c76a262b-4818-5ef0-58bf-2bc3353cb6bd@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466735172-13372-1-git-send-email-chris@cpdesign.com.au>
 <20160628181636.GA2391@earth>
Reply-To: chris-oDmnclXj83W6c6uEtOJ/EA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160628181636.GA2391@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

Sorry about the extra dtsi file, I accidentally included it in the v5 
patch set (wasn't in <= v4).

Thanks,
Chris

On 29/06/2016 4:16 AM, Sebastian Reichel wrote:
> Hi Chris,
>
> On Fri, Jun 24, 2016 at 12:26:05PM +1000, Chris Lapa wrote:
>> This patch set adds device tree support for the MAX8903 battery charger.
>> It also cleans up logic with dc_valid, dok and dcm pins as well as
>> fixing up validity checking of gpios.
>>
>> I verified these patches work on a board I have here, which uses the
>> DC power side (not the USB portition) of the MAX8903.
>
> I queued this into my for-next branch, except for the dtsi file,
> which I dropped from your first patch. Please submit it separately
> to the correct maintainers.
>
> [...]
>
>>  arch/arm/boot/dts/dairytest-servo.dtsi             |  36 ++++
>
> [...]
>
> -- Sebastian
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
