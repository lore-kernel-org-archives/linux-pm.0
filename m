Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583398;
	b=iyDNUe/wTfUNkgXJiYMI3ZofJsWYxZ5eHcipn8tDXb0fJnZUJ9RgJ/EiiJvjs7nDHMyG
	 QuVKEO2KMAOS8E76NcfyxH99azy+4jvm+tfZE2y51NFAMk0Rg+9EyJGYCzluYeQDkUQ7K
	 7ErNyahqmkJIXAYRKklM4kQLDtojVY7sdTYBNvu7kjg0w3bH0/y2d3W6i7PFv3c/BsVYk
	 aut1d73K5dI61u85PmjmzkHIVHr5WNITRVa/er+ZTem9aeI3Pn+rLKsm0nNHQt8neW4Q5
	 tekfbQT54dK41dYVxKhQgttoAwX1H+279Yv7vY0poX+ckoUPcci8te3RK416AuMN0ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583398;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YDVppn0FtPTAoW92GB6F9wY+Pi+oD1L4w+QiqVADsKo=;
	b=mVJbB2XhVxPvfM+pyT47zKiJ5xSN2MvDkgY7MsG2c/kzgtqa+e0xtfkrlYA4IjH6h1lf
	 3mwQCR/qcv5X5qBfxZRn1KjmlVObZmohbH5chNg3t1Kvv34fKqGdH2hIUBoc1fxb/6cao
	 AzqB0yaSmvBWn+2l+ymtCMHKJia6wKum+Ms38/fKSUZ/69YuhtxD/tPerZ+lBYWmXYMBS
	 ZsDqZvj3SY687FNvo7hVj5G2Rd6VnCazMhAtPvGVwVysIAhxexQScU9CJ4hw+a2jWTP6U
	 gdstcb4YFQjtmJC2Je7UmaFPSnqFtno4gU7nj9hH5fX8/0Bfes48HmQGQmgj8cCf89g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qky5B3Vp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB6606A335
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qky5B3Vp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC071F000C7
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583398;
	bh=YDVppn0FtPTAoW92GB6F9wY+Pi+oD1L4w+QiqVADsKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Qky5B3VpjT1qZOKiK0dBTUax0T7lnbuzhTxpKlJR27roj7DK/KZjhgfhSk31aIrqq
	 fA8FSou3d3RaqCVqKvYaMZZ7GfLGuhy88L2HSQrVmvBjrJy158hVdXA51ttEkl3nef
	 2UsHTJOiXiasmqxnytKZiZeb+GwuA6jhkoJVML1XuiMkCOWLHM5HqbeCdj4J/SQJGp
	 oRKyXEMXsrkYN+H0n3v+0CEoLJO8A+7o+mxWizHsl8xOF3cotQCzGIHkTCe0zrNYOq
	 RxQSmFjDQHqU/OIiRtkzKo7AZZC6FBAZ/T91NI4TkBoFFupWrnglfZnFpb7NBmWqRI
	 vwMWnnnG/mWDQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c15956ce07so2189832e87.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 07:23:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFjkOMJu3eN/drHKsbg27yEaxMKCJ2bpLVNfDrkum9oTnFiyE4ImD1gEBASYWZFkoirQk4xSaqYRA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9NkoX8wQAx9vGt+aP9pF0He3Zd+71KhJGWwhSkEoPrGROBKsj3
	p2rmGypbDPXPIxgk1d84JaH6sOswBuCwHofGLkH3zvgISM7/5UvZ+/wlrWfcsL8tZD9Dl+B8/2h
	1OamuuSE8s/vE0CMMORVXONaNx7E7FyI=
X-Received: by 2002:a05:6512:1281:b0:5ba:3e27:6a32 with SMTP id
 2adb3069b0e04-5c164eaae7amr2390025e87.29.1794583396001; Fri, 13 Nov 2026
 07:23:16 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027154519.v5.1.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
In-Reply-To: <20261027154519.v5.1.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 16:23:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ij3BHPyujfb_ZCqpcz_dDwDi2o6EomeeFt8zQ27Zfiyw@mail.gmail.com>
X-Gm-Features: AclHuK8mhN04hVaINXou9K-q2MRhSAxUj3QUASHRa50VMuLQjZhFjHr9xkK1-mw
Message-ID: <CAJZ5v0ij3BHPyujfb_ZCqpcz_dDwDi2o6EomeeFt8zQ27Zfiyw@mail.gmail.com>
Subject: Re: [PATCH v5] PM: runtime: Add Example Driver Patterns section
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Doug Anderson <dianders@chromium.org>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:45=E2=80=AFPM Brian Norris <briannorris@chromium=
.org> wrote:
>
> The runtime PM API surface is pretty large, but there are a few common
> patterns that many drivers should follow. Add some illustrative
> examples, to help guide the most common audience for runtime PM docs --
> driver writers.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> This was previously part of a series:
>    "PM: runtime: Overhaul kerneldoc, runtime_pm.rst docs"
> The rest of the series has been applied, so this is now just 1 patch.
>
> v1 is here:
> https://lore.kernel.org/all/20260904212000.4167880-1-briannorris@chromium=
.org/
>
> v2 is here:
> https://lore.kernel.org/all/20260923174711.1283986-1-briannorris@chromium=
.org/
>
> v3 is here:
> https://lore.kernel.org/all/20260930025044.104824-1-briannorris@chromium.=
org/
>
> v4 is here:
> https://lore.kernel.org/all/20261001155118.1750028-1-briannorris@chromium=
.org/
>
> I've tried to account for all the feedback from prior revisions, but
> runtime PM is complicated, and it's hard to make a one-size-fits-all
> (or, 3 to 6 sizes fit all?) example solution that covers all the most
> relevant topics, without leaving too many unexplained/unaccounted corner
> cases. I hope I struck the right balance.
>
> Changes in v5:
>  * Account for differing assumptions about initial device state,
>    especially with ACPI and with PM domains.
>  * Try to more precisely talk about "operational" and "non-operational"
>    states, in case "powered on/off" has a different or confusing meaning
>    (especially when considering PM domains).
>  * Expand some of the pseudocode/comments to be more realistic and clear
>    about what the code (foo_runtime_suspend(), foo_initialize(), etc.)
>    is doing.
>  * Be more verbose about what each step is doing, and what the entry and
>    exit conditions look like.
>
> Changes in v4:
>  * "state" to "status", to be consistent with Introduction terminology
>
> Changes in v3:
>  * Rewrite Examples to avoid devm_* at first, to highlight correct
>    approaches
>  * Include error-handling and remove() in any probe() Examples
>  * Advise more caution when using devm_*, as ordering issues are subtle
>
> Changes in v2:
>  * Add appropriate teardown to "Probe with Hardware Powered Off"
>    Example, as the remove() + power-off behavior is subtle here, and
>    easy to get wrong
>
>  Documentation/power/runtime_pm.rst | 567 ++++++++++++++++++++++++++++-
>  1 file changed, 565 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/run=
time_pm.rst
> index 40a5c23d5259..ef9e02ba893f 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -429,7 +429,8 @@ in ->probe(). Usually this means calling pm_runtime_d=
isable() etc.
>  Alternatively, drivers can use devm_pm_runtime_enable() during probe, wh=
ich
>  automatically takes care of calling pm_runtime_disable() upon driver det=
achment.
>  Any pm_runtime_use_autosuspend() calls in a driver will be automatically=
 undone
> -on driver exit.
> +on driver exit. See also the Examples in `Section 10`_ for some effectiv=
e
> +strategies for driver teardown.
>
>  The user space can effectively disallow the driver of the device to powe=
r manage
>  it at run time by changing the value of its /sys/devices/.../power/contr=
ol
> @@ -654,7 +655,9 @@ The implementation is well suited for asynchronous us=
e in interrupt contexts.
>  However such use inevitably involves races, because the PM core can't
>  synchronize ->runtime_suspend() callbacks with the arrival of I/O reques=
ts.
>  This synchronization must be handled by the driver, using its private lo=
ck.
> -Here is a schematic pseudo-code example::
> +Here is a schematic pseudo-code example:
> +
> +.. code-block:: c
>
>         foo_read_or_write(struct foo_priv *foo, void *data)
>         {
> @@ -720,3 +723,563 @@ pm_runtime_autosuspend_expiration() from within the=
 ->runtime_suspend()
>  callback while holding its private lock.  If the function returns a nonz=
ero
>  value then the delay has not yet expired and the callback should return
>  -EAGAIN.
> +
> +.. _Section 10:
> +
> +10. Example Driver Patterns
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +The runtime PM API is large and complex, but most device drivers follow =
a small
> +set of canonical patterns when interacting with runtime PM. This section
> +illustrates standard patterns for device probing, performing I/O, and ha=
ndling
> +interrupts.
> +
> +Probe and Initialization
> +------------------------
> +
> +There are at least two general strategies regarding how to initialize a =
device
> +in a driver that wants to use runtime PM: one in which the driver fully =
brings
> +the device to an operational state before enabling runtime PM, and one i=
n which
> +the driver does not. We explore example driver patterns for those two ap=
proaches
> +in the following two examples, and then explore an example with devres-b=
ased
> +resource teardown and with autosuspend.
> +
> +Enabling a Fully Operational Device
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +In this approach, a driver expects to find its device initially in a
> +non-operational state, and it intends to bring the device into an operat=
ional
> +state before enabling runtime PM. Such a device may initially be powered=
 on to
> +some extent (e.g., by a PM domain, which is powered on by the PM core), =
but it
> +may still require device-specific initialization (e.g., clocks, regulato=
rs,
> +device-specific programming) to become fully operational. Such a driver'=
s
> +probe() routine should perform any device-specific initialization, mark =
the
> +device **active**, and then enable runtime PM. On probe() errors and in
> +remove(), the driver should perform all these steps in reverse.
> +
> +.. code-block:: c
> +
> +       static int foo_initialize(struct platform_device *pdev)
> +       {
> +               /*
> +                * Perform device-specific initialization, to bring the d=
evice
> +                * into an operational state. For example, enable clocks,=
 bring
> +                * device out of reset, etc.
> +                *
> +                * In some cases, one may choose to share this code with =
the
> +                * driver's .runtime_resume() implementation.
> +                */
> +
> +               [...]
> +
> +               return 0;
> +       }
> +
> +       static int foo_teardown(struct platform_device *pdev)
> +       {
> +               /*
> +                * Perform device-specific teardown/power-down.
> +                *
> +                * In some cases, one may choose to share this code with =
the
> +                * driver's .runtime_suspend() implementation.
> +                */
> +
> +               [...]
> +
> +               return 0;
> +       }
> +
> +       static int foo_probe(struct platform_device *pdev)
> +       {
> +               struct device *dev =3D &pdev->dev;
> +               struct foo_priv *priv;
> +               int ret;
> +
> +               priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +               if (!priv)
> +                       return -ENOMEM;
> +
> +               platform_set_drvdata(pdev, priv);
> +
> +               /* Acquire regulators, clocks, GPIOs, and register map...=
 */
> +               [...]
> +
> +               ret =3D foo_initialize(pdev);
> +               if (ret)
> +                       return ret;
> +
> +               /*
> +                * The code above left hardware powered on and operationa=
l, so
> +                * tell the PM core that the device is active before enab=
ling
> +                * runtime PM.
> +                */
> +               pm_runtime_set_active(dev);
> +
> +               /* After this point, the device may suspend. */
> +               pm_runtime_enable(dev);
> +
> +               /*
> +                * Perform remaining driver setup (e.g. register interrup=
ts,
> +                * device nodes). If any step fails after enabling runtim=
e PM,
> +                * we must unwind the PM initialization process.
> +                */
> +               ret =3D foo_register_device(priv);
> +               if (ret)
> +                       goto err_pm_disable;
> +
> +               /*
> +                * Upon successful return from ->probe(), the driver core
> +                * automatically executes pm_request_idle(dev), allowing =
the
> +                * device to suspend asynchronously if its usage counter =
is zero.
> +                */
> +               return 0;
> +
> +       err_pm_disable:
> +               /*
> +                * Ensure the device is active, so we tear it down from a
> +                * consistent state.
> +                */
> +               pm_runtime_get_sync(dev);
> +
> +               /* Tear down in reverse order of initialization. */
> +               pm_runtime_disable(dev);
> +               pm_runtime_set_suspended(dev);
> +               foo_teardown(pdev);
> +
> +               /* Drop the reference we acquired a few lines above. */
> +               pm_runtime_put_noidle(dev);
> +
> +               return ret;
> +       }
> +
> +       static void foo_remove(struct platform_device *pdev)
> +       {
> +               struct device *dev =3D &pdev->dev;
> +               struct foo_priv *priv =3D platform_get_drvdata(pdev);
> +
> +               foo_unregister_device(priv);
> +
> +               /*
> +                * Ensure the device is active, so we tear it down from a
> +                * consistent state.
> +                */
> +               pm_runtime_get_sync(dev);
> +
> +               pm_runtime_disable(dev);
> +               pm_runtime_set_suspended(dev);
> +               foo_teardown(pdev);
> +
> +               /* Drop the reference we acquired a few lines above. */
> +               pm_runtime_put_noidle(dev);
> +       }
> +
> +Drivers using this pattern should ensure that hardware is left back at i=
ts
> +initial state upon driver remove() or probe() error. This generally mean=
s
> +unwinding any resource acquisition and undoing any programming sequences=
 in
> +reverse of the order performed in probe(). However, runtime PM has addit=
ional
> +state to consider -- the device may potentially be either **active** or
> +**suspended** during teardown, even if the device is otherwise currently=
 unused.
> +Consider, for example, if user space configured
> +``/sys/devices/.../power/control`` to ``on``, or if the device has not y=
et
> +idled.
> +
> +Thus, ``foo_remove()`` and ``err_pm_disable`` first ensure the device is=
 active,
> +and then disable runtime PM and tear down the device to its initial prob=
e()
> +state.
> +
> +Note that for some devices (e.g., devices with an ACPI PM domain),
> +foo_initialize() and foo_teardown() may be minimal or even empty, as the=
 PM
> +domain performed the power-on work. Such drivers may still follow this g=
eneral
> +pattern, but also may be even simpler in some cases.
> +
> +Also note that device-managed helpers such as devm_pm_runtime_enable() a=
nd
> +devm_pm_runtime_set_active_enabled() exist, but they only call
> +pm_runtime_disable() upon driver unbind; they do not take care of device=
 quiesce
> +and power-off. See the `Autosuspend and Device-Managed Probe`_ section b=
elow for
> +how to encapsulate complete teardown in a custom devm action.
> +
> +Enabling a Device in a Non-Operational State
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +As an alternative approach, some drivers prefer to keep hardware powered=
 off or
> +in a low power non-operational state until actually needed, avoiding dup=
licate
> +power sequencing logic between ->probe() and ->runtime_resume(), and pot=
entially
> +even avoiding unneeded power transitions during probe(). Because the ini=
tial
> +runtime PM status of a device is suspended by default, the driver can en=
able
> +runtime PM directly and rely on pm_runtime_resume_and_get() to trigger t=
he
> +->runtime_resume() callback when the driver needs to access hardware:
> +
> +.. code-block:: c
> +
> +       static int foo_runtime_suspend(struct device *dev)
> +       {
> +               struct foo_priv *priv =3D dev_get_drvdata(dev);
> +
> +               clk_disable_unprepare(priv->clk);
> +               regulator_disable(priv->supply);
> +
> +               return 0;
> +       }
> +
> +       static int foo_runtime_resume(struct device *dev)
> +       {
> +               struct foo_priv *priv =3D dev_get_drvdata(dev);
> +               int ret;
> +
> +               ret =3D regulator_enable(priv->supply);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D clk_prepare_enable(priv->clk);
> +               if (ret) {
> +                       regulator_disable(priv->supply);
> +                       return ret;
> +               }
> +
> +               return 0;
> +       }
> +
> +       static int foo_probe(struct platform_device *pdev)
> +       {
> +               struct device *dev =3D &pdev->dev;
> +               struct foo_priv *priv;
> +               int ret;
> +
> +               priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +               if (!priv)
> +                       return -ENOMEM;
> +
> +               platform_set_drvdata(pdev, priv);
> +
> +               /* Acquire regulators, clocks, GPIOs, and register map...=
 */
> +               [...]
> +
> +               /*
> +                * Hardware starts in a non-operational state. The defaul=
t
> +                * status is RPM_SUSPENDED, so no need for:
> +                * pm_runtime_set_suspended(dev);
> +                */
> +
> +               pm_runtime_enable(dev);
> +
> +               /*
> +                * Optional: power on the device via ->runtime_resume() t=
o
> +                * verify device ID or perform initial hardware configura=
tion.
> +                */
> +               ret =3D pm_runtime_resume_and_get(dev);
> +               if (ret < 0)
> +                       goto err_pm_disable;
> +
> +               ret =3D foo_verify_hardware_id(priv);
> +               if (ret) {
> +                       pm_runtime_put_sync(dev);
> +                       goto err_pm_disable;
> +               }
> +
> +               /*
> +                * Drop the usage counter, allowing ->runtime_suspend() t=
o
> +                * power off the device until an I/O request arrives.
> +                */
> +               pm_runtime_put(dev);
> +
> +               return 0;
> +
> +       err_pm_disable:
> +               pm_runtime_disable(dev);
> +               if (!pm_runtime_status_suspended(dev)) {
> +                       foo_runtime_suspend(dev);
> +                       pm_runtime_set_suspended(dev);
> +               }
> +               return ret;
> +       }
> +
> +       static void foo_remove(struct platform_device *pdev)
> +       {
> +               struct device *dev =3D &pdev->dev;
> +
> +               pm_runtime_disable(dev);
> +               if (!pm_runtime_status_suspended(dev)) {
> +                       foo_runtime_suspend(dev);
> +                       pm_runtime_set_suspended(dev);
> +               }
> +       }
> +
> +Similar to the previous example, drivers using this pattern also must ex=
ercise
> +care when handling probe() errors or performing unbind/remove(), to ensu=
re they
> +clean up resources that they manage with runtime suspend/resume, and gen=
erally
> +leave the device in the same state it was when the driver first probed. =
And
> +again, one must consider that the device can be either **active** or
> +**suspended** while unwinding. Typically, this may mean explicitly suspe=
nding
> +the device if not already suspended.
> +
> +Note that this pattern requires ``CONFIG_PM``. When ``CONFIG_PM`` is dis=
abled,
> +pm_runtime_resume_and_get() returns 0 without calling ->runtime_resume()=
,
> +leaving hardware unpowered. Drivers using this pattern should typically =
depend
> +on ``CONFIG_PM``.
> +
> +Autosuspend and Device-Managed Probe
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +If the driver wants to use autosuspend, it should first configure the
> +autosuspend delay and enable autosuspend before enabling runtime PM.
> +
> +Additionally, drivers can use device-managed (``devm_*``) helpers to cle=
an up
> +resources on probe failure or driver unbind. This provides an alternativ=
e to
> +writing complicated ``goto``-based error paths, with similar teardown co=
de in
> +remove(). Note that drivers must still exercise care to avoid assuming a
> +particular runtime PM status in these cases; a device may be either **ac=
tive**
> +or **suspended**, and so ``devm``-based teardown code must be written
> +accordingly.
> +
> +.. code-block:: c
> +
> +       static int foo_runtime_suspend(struct device *dev)
> +       {
> +               return foo_teardown(to_platform_device(dev));
> +       }
> +
> +       static int foo_runtime_resume(struct device *dev)
> +       {
> +               return foo_initialize(to_platform_device(dev));
> +       }
> +
> +       /* Tear-down action, for error handling or driver unbind. */
> +       static void foo_poweroff_action(void *data)
> +       {
> +               struct device *dev =3D data;
> +
> +               /* Runtime PM is already disabled by this point. */
> +
> +               if (!pm_runtime_status_suspended(dev)) {
> +                       /*
> +                        * Power device back off, in case device was left=
 active.
> +                        * e.g., leverage .runtime_suspend() routine:
> +                        */
> +                       foo_runtime_suspend(dev);
> +
> +                       pm_runtime_set_suspended(dev);
> +               }
> +       }
> +
> +       static int foo_probe(struct platform_device *pdev)
> +       {
> +               struct device *dev =3D &pdev->dev;
> +               struct foo_priv *priv;
> +               int ret;
> +
> +               priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +               if (!priv)
> +                       return -ENOMEM;
> +
> +               platform_set_drvdata(pdev, priv);
> +
> +               /* Acquire regulators, clocks, GPIOs, and register map...=
 */
> +               [...]
> +
> +               /* Power on and initialize hardware registers... */
> +               ret =3D foo_initialize(pdev);
> +               if (ret)
> +                       return ret;
> +
> +               pm_runtime_set_active(dev);
> +
> +               /*
> +                * Guarantee hardware is powered off upon unbind or probe=
 error.
> +                * Register this action before devm_pm_runtime_enable() t=
o
> +                * ensure runtime PM status is frozen by the time we tear=
 down
> +                * here.
> +                */
> +               ret =3D devm_add_action_or_reset(dev, foo_poweroff_action=
, dev);
> +               if (ret)
> +                       return ret;
> +
> +               /* Set autosuspend delay (e.g., 2000 ms) and enable autos=
uspend. */
> +               pm_runtime_set_autosuspend_delay(dev, 2000);
> +               pm_runtime_use_autosuspend(dev);
> +
> +               /*
> +                * Update last busy timestamp so the driver core's post-p=
robe
> +                * pm_request_idle() respects the autosuspend delay.
> +                */
> +               pm_runtime_mark_last_busy(dev);
> +
> +               /*
> +                * devm_pm_runtime_enable() ensures that pm_runtime_disab=
le()
> +                * and pm_runtime_dont_use_autosuspend() are called upon =
driver
> +                * unbind.
> +                */
> +               ret =3D devm_pm_runtime_enable(dev);
> +               if (ret)
> +                       return ret;
> +
> +               return 0;
> +       }
> +
> +Key points:
> +
> +* **Guaranteed Power-off on Detach**: Again similar to the previous exam=
ples, we
> +  must exercise care in case the device was still active during probe fa=
ilure or
> +  driver unbind. In this case, we encapsulate the teardown using device-=
managed
> +  actions.
> +* **LIFO Teardown Ordering**: Because ``devm`` releases resources in rev=
erse
> +  order of registration (LIFO), registering foo_poweroff_action() before
> +  devm_pm_runtime_enable() ensures that runtime PM is disabled first, an=
d the
> +  device is suspended *before* devm disables any clocks or regulators ac=
quired
> +  earlier in ->probe().
> +* **Omission of ->remove()**: If all other resources in the driver are m=
anaged
> +  with ``devm`` helpers, this eliminates both manual ``goto``-based unwi=
nding in
> +  ->probe() and the need for an explicit ->remove() callback.
> +* **Initialization vs suspend/resume symmetry**: This example exploits t=
he fact
> +  that device-state initialization/teardown is often similar or identica=
l to
> +  runtime_resume()/runtime_suspend(), making it easier to perform approp=
riate
> +  teardown in ``devm_`` teardown. If this is not the case, this becomes =
more
> +  complicated, and ``devm_`` may not be the right approach to use.
> +
> +Performing I/O Operations
> +-------------------------
> +
> +Before accessing hardware registers or initiating I/O transfers, drivers=
 must
> +ensure the device is active by calling pm_runtime_resume_and_get() or si=
milar.
> +
> +Basic I/O
> +~~~~~~~~~
> +
> +For devices without autosuspend, work completion is signaled with
> +pm_runtime_put(), which drops the usage counter and queues an asynchrono=
us idle
> +check once the counter reaches zero:
> +
> +.. code-block:: c
> +
> +       int foo_do_transfer(struct foo_priv *priv, void *buf, size_t coun=
t)
> +       {
> +               int ret;
> +
> +               ret =3D pm_runtime_resume_and_get(priv->dev);
> +               if (ret < 0)
> +                       return ret;
> +
> +               /* Access hardware registers or perform data transfer... =
*/
> +               ret =3D foo_hardware_transfer(priv, buf, count);
> +
> +               /*
> +                * Drop usage counter and request asynchronous idle check=
 (and
> +                * suspend, if possible).
> +                */
> +               pm_runtime_put(priv->dev);
> +
> +               return ret;
> +       }
> +
> +Autosuspend I/O
> +~~~~~~~~~~~~~~~
> +
> +For devices using autosuspend, work completion is signaled with
> +pm_runtime_put_autosuspend(), which drops the usage counter and defers
> +suspension until the autosuspend delay expires:
> +
> +.. code-block:: c
> +
> +       int foo_do_transfer(struct foo_priv *priv, void *buf, size_t coun=
t)
> +       {
> +               int ret;
> +
> +               ret =3D pm_runtime_resume_and_get(priv->dev);
> +               if (ret < 0)
> +                       return ret;
> +
> +               /* Access hardware registers or perform data transfer... =
*/
> +               ret =3D foo_hardware_transfer(priv, buf, count);
> +
> +               /*
> +                * Drop the usage counter and schedule an autosuspend onc=
e
> +                * the delay expires. Note that pm_runtime_put_autosuspen=
d()
> +                * updates the last-access timestamp automatically.
> +                */
> +               pm_runtime_put_autosuspend(priv->dev);
> +
> +               return ret;
> +       }
> +
> +Synchronous Completion
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +When immediate suspension is desired -- such as before unregistering a d=
evice or
> +during shutdown -- synchronous put helpers can be used instead of their
> +asynchronous counterparts. Which helper to use depends on whether autosu=
spend is
> +configured:
> +
> +* For non-autosuspend devices, use pm_runtime_put_sync().
> +* For devices that use autosuspend, use pm_runtime_put_sync_suspend(), w=
hich
> +  ignores any configured autosuspend delay and forces immediate suspensi=
on.
> +
> +However, note several important caveats when relying on synchronous runt=
ime
> +PM helpers for power-down:
> +
> +* **Parents and Suppliers**: While the target device itself is suspended
> +  synchronously, the PM core handles idle notifications for parents and
> +  device link suppliers asynchronously. As a result, parent devices or
> +  power domain suppliers are not guaranteed to be powered off when the
> +  function returns.
> +* **User Policy ("Forbidden")**: Runtime PM helpers respect system polic=
y.
> +  If user space has set ``/sys/devices/.../power/control`` to ``on``
> +  (pm_runtime_forbid()), the PM core holds an extra reference on the
> +  device, meaning dropping the driver's usage counter will not trigger a
> +  suspend.
> +
> +Because of these constraints, synchronous put helpers may not be suitabl=
e when a
> +driver functionally requires hardware to be powered off synchronously (f=
or
> +example, to perform a hardware reset or power cycle). Such requirements =
may
> +necessitate other methods, such as disabling runtime PM with
> +pm_runtime_disable() and explicitly executing the hardware power-down se=
quence.
> +
> +Interrupt Handling with Conditional Get
> +---------------------------------------
> +
> +Interrupt handlers (especially in atomic or hardirq context) cannot typi=
cally
> +invoke pm_runtime_resume_and_get(), because runtime-resume may sleep. Mo=
reover,
> +if an interrupt arrives while the device is suspended or transitioning t=
o low
> +power (e.g., on a shared interrupt line or spurious wakeups), attempting=
 to read
> +hardware registers could trigger a bus fault or system hang.
> +
> +To handle this safely, drivers can conditionally acquire a runtime PM re=
ference
> +using pm_runtime_get_if_in_use() or pm_runtime_get_if_active():
> +
> +.. code-block:: c
> +
> +       static irqreturn_t foo_irq_handler(int irq, void *dev_id)
> +       {
> +               struct foo_priv *priv =3D dev_id;
> +               irqreturn_t ret =3D IRQ_NONE;
> +
> +               /*
> +                * Check if the device is active before reading hardware
> +                * registers. If the device is suspended, this interrupt
> +                * cannot belong to us (or was already serviced).
> +                *
> +                * Note that this also will drop interrupts while runtime=
 PM is
> +                * disabled.
> +                */
> +               if (pm_runtime_get_if_active(priv->dev) <=3D 0)
> +                       return IRQ_NONE;
> +
> +               /* Hardware is active and usage count is incremented */
> +               if (foo_has_pending_irq(priv)) {
> +                       foo_service_irq(priv);
> +                       ret =3D IRQ_HANDLED;
> +               }
> +
> +               /*
> +                * Release the reference acquired by pm_runtime_get_if_ac=
tive().
> +                * For autosuspend devices, use pm_runtime_put_autosuspen=
d();
> +                * for non-autosuspend devices, use pm_runtime_put().
> +                */
> +               pm_runtime_put_autosuspend(priv->dev);
> +
> +               return ret;
> +       }
> +
> +Both pm_runtime_get_if_in_use() and pm_runtime_get_if_active() are safe =
to use
> +from an interrupt routine. One example where a device might be active bu=
t not
> +"in use" is if autosuspend is used. A device will stay active for a whil=
e with
> +no users. If interrupts should still be serviced for a device in this st=
ate,
> +pm_runtime_get_if_active() should be used.
> --

Applied as 7.5 material, thanks!
