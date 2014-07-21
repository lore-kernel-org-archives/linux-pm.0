From: Matthew Longnecker <mlongnecker@nvidia.com>
Subject: Re: [PATCH 4/6] ARM: tegra: Add soctherm and thermal zones to Tegra124
 device tree
Date: Mon, 21 Jul 2014 16:13:13 -0700
Message-ID: <53CD9E89.3030109@nvidia.com>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
 <1403856699-2140-5-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1403856699-2140-5-git-send-email-mperttunen@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 6/27/2014 1:11 AM, Mikko Perttunen wrote:
> This adds the soctherm thermal sensing and management unit to the
> Tegra124 device tree along with the four thermal zones it exports.

Mikko, soctherm doesn't "export thermal zones". I would rewrite your 
desription like this:

   Extend the Tegra124 device tree by adding the soctherm thermal
   sensing and management unit and by defining four thermal zones --
   one for each temperature sensor in soctherm.

System integrators have some flexibility in deciding how many thermal 
zones to define for their platform. For example, an integrator could 
define a single zone for the entire Tegra chip (giving a simple system 
at runtime) or with multiple zones (giving potentially higher 
performance near thermal limits). That's why I don't like the 
implication that soctherm dictates the existence of particular thermal 
zones.

-Matt
