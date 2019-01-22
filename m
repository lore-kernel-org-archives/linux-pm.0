From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v13 0/8] Introduce on-chip interconnect API
Date: Tue, 22 Jan 2019 16:00:49 +0100
Message-ID: <20190122150048.GA11466@kroah.com>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
 <20190122124204.GA26969@kroah.com>
 <2ac9b994-ecbf-05fd-5c01-7ecd0089c744@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <2ac9b994-ecbf-05fd-5c01-7ecd0089c744@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: sanjayc@nvidia.com, maxime.ripard@bootlin.com, mturquette@baylibre.com, daidavid1@codeaurora.org, bjorn.andersson@linaro.org, skannan@codeaurora.org, abailon@baylibre.com, vincent.guittot@linaro.org, seansw@qti.qualcomm.com, khilman@baylibre.com, evgreen@chromium.org, ksitaraman@nvidia.com, devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, henryc.chen@mediatek.com, andy.gross@linaro.org, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, dianders@chromium.org, amit.kucheria@linaro.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, olof@lixom.net
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 22, 2019 at 04:45:20PM +0200, Georgi Djakov wrote:
> On 1/22/19 14:42, Greg KH wrote:
> > On Wed, Jan 16, 2019 at 06:10:55PM +0200, Georgi Djakov wrote:
> [..]
> > 
> > All now queued up, thanks.
> > 
> > greg k-h
> 
> Hi Greg,
> 
> Thanks for considering these patches! Actually i have a branch named
> icc-next [1] which is pulled into linux-next. I will drop these same
> patches to avoid conflicts.
> 
> If all is well, i was wondering how to proceed with follow-up patches.
> Some consumers of this API are already floating on the lists. How about
> sending you a pull request before the merge window with the collected
> patches?

Sure, that works, or you can just send them as patches, either works for
me.

greg k-h
