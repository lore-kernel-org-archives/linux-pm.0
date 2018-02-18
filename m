From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 09/10] dt-bindings: cpufreq-dt: Remove
 "cooling-{min|max}-level" properties
Date: Sun, 18 Feb 2018 17:26:56 -0600
Message-ID: <20180218232656.bjkomzkuv2my3ngy@rob-hp-laptop>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <aef1b506b365920d82b17c0712a3428196f72dc5.1518166039.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <aef1b506b365920d82b17c0712a3428196f72dc5.1518166039.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 09, 2018 at 02:28:09PM +0530, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of kernel currently and the max cooling state of a
> CPU cooling device is found by referring to the cpufreq table instead.
> 
> Remove the unused bindings.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
