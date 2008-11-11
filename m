From: Mathieu Chouquet-Stringer <mchouque@free.fr>
Subject: Re: Suspend to disk broken in latest 2.6.28-rc3
Date: Tue, 11 Nov 2008 16:27:36 +0100
Message-ID: <20081111152736.GA28569__6660.46837945959$1226418014$gmane$org@mobydick>
References: <20081109195033.GA1335@mobydick>
	<20081110094239.GA14204@atrey.karlin.mff.cuni.cz>
	<20081110221343.GA17951@mobydick>
	<200811101506.53324.jbarnes@virtuousgeek.org>
	<20081110231524.GA18971@mobydick>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081110231524.GA18971@mobydick>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Pavel Machek <pavel@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.or
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 11, 2008 at 12:15:24AM +0100, Mathieu Chouquet-Stringer wrote:
> This one I guess:
> http://bugzilla.kernel.org/attachment.cgi?id=18644&action=view
> 
> Let me give it a shot, I'll keep you posted.

So I compiled the module, rebooted just to have a clean starting point,
started X then tried to suspend: no go...
-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr
            The sun itself sees not till heaven clears.
	             -- William Shakespeare --
