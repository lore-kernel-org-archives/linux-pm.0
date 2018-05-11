From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v4 7/7] interconnect: Allow endpoints translation via DT
Date: Fri, 11 May 2018 14:29:19 -0700
Message-ID: <CAE=gft4-gBsdmwVOModwq1iNw91phc0Zp9Qvy8jqPiBYo4Zp5A@mail.gmail.com>
References: <20180309210958.16672-1-georgi.djakov@linaro.org> <20180309210958.16672-8-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309210958.16672-8-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: georgi.djakov@linaro.org
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 9, 2018 at 1:10 PM Georgi Djakov <georgi.djakov@linaro.org>
wrote:

> Currently we support only platform data for specifying the interconnect
> endpoints. As now the endpoints are hard-coded into the consumer driver
> this may leed to complications when a single driver is used by multiple

Nit: s/leed/lead/

-Evan
