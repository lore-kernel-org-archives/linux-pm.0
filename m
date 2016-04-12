From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] i2c: let I2C masters ignore their children for PM
Date: Tue, 12 Apr 2016 12:04:52 +0200
Message-ID: <CAPDyKFpDHZTgjyK2N3k26u1k_RHxm11=6UGuczPguhkZKh+iFg@mail.gmail.com>
References: <1460447855-18050-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1460447855-18050-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12 April 2016 at 09:57, Linus Walleij <linus.walleij@linaro.org> wrote:
> When using a certain I2C device with runtime PM enabled on
> a certain I2C bus adaper the following happens:
>
> struct amba_device *foo
>    \
>    struct i2c_adapter *bar
>       \
>       struct i2c_client *baz
>
> The AMBA device foo has its device PM struct set to ignore
> children with pm_suspend_ignore_children(&foo->dev, true).
> This makes runtime PM work just fine locally in the driver:
> the fact that devices on the bus are suspended or resumed
> individually does not affect its operation, and the hardware
> does not power up unless transferring messages.
>
> However this child ignorance property is not inherited into
> the struct i2c_adapter *bar.
>
> On system suspend things will work fine.
>
> On system resume the following annoying phenomenon occurs:
>
> - In the pm_runtime_force_resume() path of
>   struct i2c_client *baz, pm_runtime_set_active(&baz->dev); is
>   eventually called.
>
> - This becomes __pm_runtime_set_status(&baz->dev, RPM_ACTIVE);
>
> - __pm_runtime_set_status() detects that RPM state is changed,
>   and checks whether the parent is:
>   not active (RPM_ACTIVE) and not ignoring its children
>   If this happens it concludes something is wrong, because
>   a parent that is not ignoring its children must be active
>   before any children activate.
>
> - Since the struct i2c_adapter *bar does not ignore
>   its children, the PM core thinks that it must indeed go
>   online before its children, the check bails out with
>   -EBUSY, i.e. the i2c_client *baz thinks it can't work
>   because it's parent is not online, and it respects its
>   parent.
>
> - In the driver the .resume() callback returns -EBUSY from
>   the runtime_force_resume() call as per above. This leaves
>   the device in a suspended state, leading to bad behaviour
>   later when the device is used. The following debug
>   print is made with an extra printg patch but illustrates
>   the problem:
>
> [   17.040832] bh1780 2-0029: parent (i2c-2) is not active
>                parent->power.ignore_children = 0
> [   17.040832] bh1780 2-0029: pm_runtime_force_resume:
>                pm_runtime_set_active() failed (-16)
> [   17.040863] dpm_run_callback():
>                pm_runtime_force_resume+0x0/0x88 returns -16
> [   17.040863] PM: Device 2-0029 failed to resume: error -16
>
> Fix this by letting all struct i2c_adapter:s ignore their
> children: i2c children have no business doing keeping
> their parents awake: they are completely autonomous
> devices that just use their parent to talk, a usecase
> which must be power managed in the host on a per-message
> basis.
>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

[...]

Kind regards
Uffe
