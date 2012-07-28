From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/4] x86 idle APM: delete apm_cpu_idle()
Date: Sat, 28 Jul 2012 11:11:48 +0100
Message-ID: <20120728111148.39ff7230@ultron>
References: <1343428975-3897-1-git-send-email-lenb@kernel.org>
	<f8c928c1d43f5c4d1342bd05ca29c8ea788726b8.1343428708.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f8c928c1d43f5c4d1342bd05ca29c8ea788726b8.1343428708.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 27 Jul 2012 18:42:53 -0400
Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
> 
> The APM idle feature to call into the BIOS
> is known to break some machines, and it has dubious benefit
> on the (decades old) machines it doesn't break.

You mean "doesn't fit my current plan" I think. I see almost no bugzilla
APM reports. It's been solid for years.

It makes a big difference on older systems as it drops the clock. If we
are going to drop this we should probaly also drop APM support entirely
and 386/486 support.

If not IMHO it should stay. Various embedded platforms are still using
ancient hardware setups.

This is a small stable piece of code that has required no maintainance in
years

Furthermore we have a feature removal process. Mark it down to be removed
in July 2013 if there are no objections, and then wait as per proper
process.

NAK

Alan
