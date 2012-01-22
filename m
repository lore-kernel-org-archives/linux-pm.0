From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH] input: CPU frequency booster
Date: Sun, 22 Jan 2012 12:55:29 +0200
Message-ID: <874nvof1lq.fsf@amiettinen-lnx.nvidia.com>
References: <1326977615-4387-1-git-send-email-amiettinen@nvidia.com>
	<20120119174459.GB25397@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:
> Does it need to be configurable? Going to max frequency for user
> interaction sounds like good idea... Probably should include keyboard,
> too.

Boosting upon all input events might be wasteful. Configurability would
allow tuning based on platform characteristics.

	--Antti
