From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] CPU C-state breakage with PM Qos change
Date: Fri, 3 Feb 2012 21:02:16 +0100
Message-ID: <201202032102.16936.rjw@sisk.pl>
References: <1328227065-22045-1-git-send-email-venki@google.com>
	<1328228079-20716-1-git-send-email-venki@google.com>
	<CAN5iSWo-n7OER4i1tPoeGBhY_RY-nX=7n4B3mFv1f0JK074bhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAN5iSWo-n7OER4i1tPoeGBhY_RY-nX=7n4B3mFv1f0JK074bhQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Pihet-XID, Jean" <j-pihet@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Venkatesh Pallipadi <venki@google.com>, markgross <markgross@thegnar.org>, linux-kernel@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, February 03, 2012, Pihet-XID, Jean wrote:
> Looping in linux-pm
> 
> On Fri, Feb 3, 2012 at 1:14 AM, Venkatesh Pallipadi <venki@google.com> wrote:
> > Looks like change "PM QoS: Move and rename the implementation files"
> > made pm_qos depend on CONFIG_PM which depends on
> > PM_SLEEP || PM_RUNTIME
> >
> > That breaks CPU C-states with kernels not having these CONFIGs, causing CPUs
> > to spend time in Polling loop idle instead of going into deep C-states,
> > consuming way way more power. This is with either acpi idle or intel idle
> > enabled.
> >
> > Either CONFIG_PM should be enabled with any pm_qos users or
> > the !CONFIG_PM pm_qos_request() should return sane defaults not to break
> > the existing users. Here's is the patch for the latter option.
> I think the real question is whether PM QoS should be functional in
> all cases (as is ACPI) or whether only if certain options are set
> (CONFIG_PM).
> In the current code if CONFIG_PM is not enabled, a dummy PM QoS API is
> provided as function stubs in order for the build to succeed.
> 
> Rafael, Mark,
> What do you think? Should PM QoS be enabled in all cases? Are there
> any known dependencies with CONFIG_PM?

At least we should keep the current behavior to avoid breaking things
for now.  We can change that in the next cycle, however, if everyone
agrees, but more carefully.

The patch has been applied to linux-pm/linux-next and will be pushed to Linus
early next week.

Thanks,
Rafael
