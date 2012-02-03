From: "Pihet-XID, Jean" <j-pihet@ti.com>
Subject: Re: [PATCH] CPU C-state breakage with PM Qos change
Date: Fri, 3 Feb 2012 15:04:43 +0100
Message-ID: <CAN5iSWo-n7OER4i1tPoeGBhY_RY-nX=7n4B3mFv1f0JK074bhQ@mail.gmail.com>
References: <1328227065-22045-1-git-send-email-venki@google.com>
	<1328228079-20716-1-git-send-email-venki@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1328228079-20716-1-git-send-email-venki@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Venkatesh Pallipadi <venki@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, markgross <markgross@thegnar.org>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Looping in linux-pm

On Fri, Feb 3, 2012 at 1:14 AM, Venkatesh Pallipadi <venki@google.com> wrote:
> Looks like change "PM QoS: Move and rename the implementation files"
> made pm_qos depend on CONFIG_PM which depends on
> PM_SLEEP || PM_RUNTIME
>
> That breaks CPU C-states with kernels not having these CONFIGs, causing CPUs
> to spend time in Polling loop idle instead of going into deep C-states,
> consuming way way more power. This is with either acpi idle or intel idle
> enabled.
>
> Either CONFIG_PM should be enabled with any pm_qos users or
> the !CONFIG_PM pm_qos_request() should return sane defaults not to break
> the existing users. Here's is the patch for the latter option.
I think the real question is whether PM QoS should be functional in
all cases (as is ACPI) or whether only if certain options are set
(CONFIG_PM).
In the current code if CONFIG_PM is not enabled, a dummy PM QoS API is
provided as function stubs in order for the build to succeed.

Rafael, Mark,
What do you think? Should PM QoS be enabled in all cases? Are there
any known dependencies with CONFIG_PM?

Regards,
Jean
