From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pm_prepare_console()
Date: Wed, 23 Apr 2008 21:41:51 +0200
Message-ID: <200804232141.52195.rjw@sisk.pl>
References: <200804231457.45354.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804231457.45354.lenb@kernel.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 23 of April 2008, Len Brown wrote:
> Rafael, Pavel,
> 
> suspend_prepare() ignores the return value of pm_prepare_console() -- assuming it always succceeds.
> 
> Is that a bug or a feature?
> (same in the hibernate code)

A feature, I'd say.

The failures of pm_prepare_console() are not considered as serious enough to
abort suspend or hibernation.

Thanks,
Rafael
