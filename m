From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
Date: Tue, 18 Oct 2016 13:25:01 +0800
Message-ID: <CAGb2v67iQikSHcwS15VmSC6fNMVG9Zya9fz6C6b5+wW43rPZfw@mail.gmail.com>
References: <20161005155112.13774-1-hdegoede@redhat.com> <20161005155112.13774-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20161005155112.13774-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dennis Gilmore <dennis@ausil.us>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 5, 2016 at 11:51 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> The i2c subsys does not load modules by compatible, only by
> i2c-id, with e.g. a modalias of: "i2c:axp209".
>
> Populate the axp20x_i2c_id[] table with supported ids, so that
> module auto-loading will work.
>
> Reported-by: Dennis Gilmore <dennis@ausil.us>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Even though axp20x-i2c seems to be the only "DT only" i2c client,
would it make sense to add DT-based module autoloading to the i2c
core?

This also made me realize we probably don't have module auto-loading
for sunxi-rsb either.

Both should be doable with Stephen Boyd's "of: device: Export
of_device_{get_modalias, uvent_modalias} to modules" patch.

Regards
ChenYu
