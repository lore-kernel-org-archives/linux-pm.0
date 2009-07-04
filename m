From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] pm: clear -EAGAIN in dpm_prepare
Date: Sun, 5 Jul 2009 01:47:03 +0200
Message-ID: <200907050147.03778.rjw@sisk.pl>
References: <alpine.LFD.2.00.0906301647520.3286@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0906301647520.3286@localhost.localdomain>
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
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 30 June 2009, Sebastian Ott wrote:
> pm: clear -EAGAIN in dpm_prepare
> 
> When the last device in the dpm list is unregistered directly after its
> prepare() callback returned with -EAGAIN, the return code is passed to
> the calling function, resulting in a resume failure. Prevent this by
> clearing the return code after -EAGAIN.
> 
> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> ---

Thanks, the patch is now in the linux-next branch of the suspend-2.6 tree.

Best,
Rafael
