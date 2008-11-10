From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend to disk broken in latest 2.6.28-rc3
Date: Mon, 10 Nov 2008 19:02:19 +0100
Message-ID: <200811101902.19855.rjw__4503.70036201111$1226340137$gmane$org@sisk.pl>
References: <20081109195033.GA1335@mobydick> <200811092059.31178.rjw@sisk.pl>
	<20081109203737.GA2056@mobydick>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081109203737.GA2056@mobydick>
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
To: Mathieu Chouquet-Stringer <mchouque@free.fr>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 9 of November 2008, Mathieu Chouquet-Stringer wrote:
> On Sun, Nov 09, 2008 at 08:59:30PM +0100, Rafael J. Wysocki wrote:
> > Please check if that's http://bugzilla.kernel.org/show_bug.cgi?id=11989 and
> > if that's the case, please add a "me too" to the bug entry.
> 
> Thanks for the quick reply, sadly I don't have CONFIG_STOP_MACHINE
> defined so that's not it...

Well, nothig obvious comes to mind.

Please check 2.6.27 and if that works, can you please bisect?

Rafael
