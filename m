From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Subject: Re: [PATCH 1/3] of: Add of_match_machine helper
Date: Mon, 18 Aug 2014 13:10:13 +0300
Message-ID: <53F1D105.1070107@nvidia.com>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>	<1407452515-2390-2-git-send-email-ttynkkynen@nvidia.com>
 <20140817152854.5406BC40ADD@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140817152854.5406BC40ADD@trevor.secretlab.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 17/08/14 18:28, Grant Likely wrote:
> On Fri, 8 Aug 2014 02:01:53 +0300, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
[...]
>> +EXPORT_SYMBOL(of_match_machine);
> 
> Too wordy...
> 
> 	return of_match_node(matches, of_allnodes);
> 
> :-)
> 
> It could be a static inline, but I don't think it's even worth having a
> helper. The callers could just open code the above.
> 

Do you mean all the drivers should be referring to of_allnodes directly?
I see that it's indeed exported, but to me that sounds like relying too
much on an implementation detail. In fact, Documentation/devicetree/todo.txt
even seems to have a TODO entry for its removal ("Remove of_allnodes list
and iterate using list of child nodes alone").

-- 
nvpublic
