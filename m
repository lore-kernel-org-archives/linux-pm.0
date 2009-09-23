From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH/RFC] Runtime PM: ARM: subarch-specific
	extensions of pdev_archdata
Date: Wed, 23 Sep 2009 16:26:02 -0700
Message-ID: <4ABAAE8A.8050608__28761.7781818428$1253748483$gmane$org@deeprootsystems.com>
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
	<20090923035411.GD31920@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090923035411.GD31920@trinity.fluff.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ben Dooks <ben@trinity.fluff.org>
Cc: linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Ben Dooks wrote:
> How about adding a Kconfig for any architectures interested in defining
> it to declare that they do not want a generic version, or some form of
> default include that could be used to support archs where this is not
> defined?
> 
> This i san awful lot of nothing header addition.
> 

I'm ok with a Kconfig option if that is preferred, but personally I 
prefer minimizing Kconfig space.

Thanks for the comments,

Kevin
