From: Tom Psyborg <pozega.tomislav@gmail.com>
Subject: Re: [PATCH 1/2] thermal: Add notifier call chain for hot/critical events
Date: Tue, 23 Oct 2018 00:08:42 +0200
Message-ID: <CAKR_QVJY3Wx4EfnvTM18Mcj_=WxKEZ=vQfM+SdmeiDn7Hm8qgA@mail.gmail.com>
References: <20181022203218.7007-1-zwisler@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181022203218.7007-1-zwisler@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ross Zwisler <zwisler@google.com>
Cc: linux-kernel@vger.kernel.org, Duncan Laurie <dlaurie@chromium.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22/10/2018, Ross Zwisler <zwisler@google.com> wrote:
> From: Duncan Laurie <dlaurie@chromium.org>
>
> This will allow drivers to register a callback for important
> thermal events and log critical thresholds that cause the system
> to shut down.

when you have proper implementation of thermal support the cores
should throttle to 80, 60 and 40% once reached passive trip point so
they never even reach critical point that causes shutdown
