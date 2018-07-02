From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] PM / Domains: Enable name based lookup at attach
Date: Mon, 2 Jul 2018 12:38:06 +0530
Message-ID: <20180702070806.tuzzh6mu65lrq4xq@vireshk-i7>
References: <20180629110432.5179-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180629110432.5179-1-ulf.hansson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Jon Hunter <jonathanh@nvidia.com>, Todor Tomov <todor.tomov@linaro.org>, linux-tegra@vger.kernel.org, Lucas Stach <dev@lynxeye.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 29-06-18, 13:04, Ulf Hansson wrote:
> Recently we added support to manage multiple PM domains per device. Consumer
> drivers were provided an API, dev_pm_domain_attach_by_id() to associate its
> device with one of its PM domain, by using an index.
> 
> Let's extend this to allow the association to be done using a name based
> lookup, which follows the similar concept as for other resource types, such as
> clocks for example.
> 
> Ulf Hansson (3):
>   PM / Domains: dt: Add a power-domain-names property
>   PM / Domains: Introduce option to attach a device by name to genpd
>   PM / Domains: Introduce dev_pm_domain_attach_by_name()

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
