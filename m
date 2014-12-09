From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] sound / PM: Replace CONFIG_PM_RUNTIME with
	CONFIG_PM
Date: Tue, 9 Dec 2014 15:09:32 +0000
Message-ID: <D0AC6CA0.260F%Brian.Austin@cirrus.com>
References: <2064254.7lXiTpmK64@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <2064254.7lXiTpmK64@vostro.rjw.lan>
Content-Language: en-US
Content-ID: <F3B38E4FEE1A904B85E89897BF7DEC9A@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kukjin Kim <kgene.kim@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Xiubo Li <Li.Xiubo@freescale.com>, Timur Tabi <timur@tabi.org>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 12/5/14, 8:46 PM, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

>From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
>After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
>selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
>depending on CONFIG_PM_RUNTIME may now be changed to depend on
>CONFIG_PM.
>
>Replace CONFIG_PM_RUNTIME with CONFIG_PM everywhere under sound/.
>
>Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>---
>
>Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
>PM_SLEEP is selected) which is only in linux-next at the moment (via the
>linux-pm tree).
>
For the cs35l32
Acked-by: Brian Austin <brian.austin@cirrus.com>
