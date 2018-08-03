From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v7 8/8] interconnect: Allow endpoints translation via DT
Date: Fri, 3 Aug 2018 15:59:56 -0700
Message-ID: <CAE=gft7+3n-Phh-FdamSFRZVq49Z234_HfU3Ze0MGJiYXGEmcw@mail.gmail.com>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-9-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180731161340.13000-9-georgi.djakov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: georgi.djakov@linaro.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Vincent Guittot <vincent.guittot@linaro.org>, arnd@arndb.de, linux-pm@vger.kernel.org, seansw@qti.qualcomm.com, gregkh@linuxfoundation.org, Michael Turquette <mturquette@baylibre.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, Bjorn Andersson <bjorn.andersson@linaro.org>, robh+dt@kernel.org, Saravana Kannan <skannan@codeaurora.org>, Alexandre Bailon <abailon@baylibre.com>, khilman@baylibre.com, linux-arm-msm@vger.kernel.org, daidavid1@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 31, 2018 at 9:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Currently we support only platform data for specifying the interconnect
> endpoints. As now the endpoints are hard-coded into the consumer driver
> this may lead to complications when a single driver is used by multiple
> SoCs, which may have different interconnect topology.
> To avoid cluttering the consumer drivers, introduce a translation function
> to help us get the board specific interconnect data from device-tree.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c  | 62 ++++++++++++++++++++++++++++++++++++
>  include/linux/interconnect.h |  7 ++++
>  2 files changed, 69 insertions(+)
>

FWIW I don't have any strong opinions on whether of_icc_get returns an
error or NULL, other than to suggest following suit with what other
frameworks have chosen to do. Though perhaps most other frameworks are
not quite as optional for a particular driver.

Reviewed-by: Evan Green <evgreen@chromium.org>
