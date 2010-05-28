From: Len Brown <lenb@kernel.org>
Subject: Re: idle-test patches queued for upstream
Date: Fri, 28 May 2010 13:42:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005281339010.4045__47963.9736972333$1275068707$gmane$org@localhost.localdomain>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<201005271045.33500.trenn@suse.de>
	<alpine.LFD.2.00.1005272023510.24823@localhost.localdomain>
	<201005281007.34706.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <201005281007.34706.trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> > Yes, Windows uses ACPI.
> > On the Dell above, that is why Linux consumes 15% less idle power
> > and why Linux can take advantage of turbo mode and Windows can not.

> You always propageted to stay Windows compatible...
> Now we go the untested way.
> Let's see how much machines will break...
> 
> Thanks for clarifications,

Don't get me wrong, Linux' ACPI "compatibility" is a huge asset.

However, there are opportunities for Linux to do better than Windows,
and I believe this is one of them.  Yes, when we take the risk of
doing something that Windows does not do, there will always be
the possibility that we will fail.

cheers,
-Len Brown, Intel Open Source Technology Center
