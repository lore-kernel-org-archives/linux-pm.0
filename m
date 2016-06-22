From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 1/8] PM / Domains: Add new helper functions for
 device-tree
Date: Wed, 22 Jun 2016 15:58:58 +0100
Message-ID: <576AA7B2.5030004@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
 <1457090634-14785-2-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1457090634-14785-2-git-send-email-jonathanh@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On 04/03/16 11:23, Jon Hunter wrote:
> Ideally, if we are returning a reference to a PM domain via a call to
> of_genpd_get_from_provider(), then we should keep track of such
> references via a reference count. The reference count could then be used
> to determine if a PM domain can be safely removed. Alternatively, it is
> possible to avoid such external references by providing APIs to access
> the PM domain and hence, eliminate any calls to
> of_genpd_get_from_provider().
> 
> Add new helper functions for adding a device and a subdomain to a PM
> domain when using device-tree, so that external calls to
> of_genpd_get_from_provider() can be removed.

While we are at it, does it make sense to add helpers for
of_genpd_remove_device/subdomain() as well? Seems that these could be
useful for doing the inverse when cleaning up.

Cheers
Jon

-- 
nvpublic
