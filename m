From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
Date: Tue, 18 Oct 2016 12:25:42 +0200
Message-ID: <bbd16837-a260-b574-1b1a-1bede038e3de@redhat.com>
References: <20161005155112.13774-1-hdegoede@redhat.com>
 <20161005155112.13774-2-hdegoede@redhat.com>
 <CAGb2v67iQikSHcwS15VmSC6fNMVG9Zya9fz6C6b5+wW43rPZfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <CAGb2v67iQikSHcwS15VmSC6fNMVG9Zya9fz6C6b5+wW43rPZfw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dennis Gilmore <dennis@ausil.us>, Maxime Ripard <maxime.ripard@free-electrons.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 18-10-16 07:25, Chen-Yu Tsai wrote:
> On Wed, Oct 5, 2016 at 11:51 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The i2c subsys does not load modules by compatible, only by
>> i2c-id, with e.g. a modalias of: "i2c:axp209".
>>
>> Populate the axp20x_i2c_id[] table with supported ids, so that
>> module auto-loading will work.
>>
>> Reported-by: Dennis Gilmore <dennis@ausil.us>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
>
> Even though axp20x-i2c seems to be the only "DT only" i2c client,
> would it make sense to add DT-based module autoloading to the i2c
> core?

If it is not too invasive, then yes that would be a sensible addition IMHO.

Regards,

Hans
