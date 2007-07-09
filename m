From: Oliver Neukum <oliver@neukum.org>
Subject: Re: malicious filesystems (was Re: Re: [PATCH] Remove
	process freezer from suspend to RAM pathway)
Date: Mon, 9 Jul 2007 11:36:32 +0200
Message-ID: <200707091136.33581.oliver__38554.8178376213$1183973842$gmane$org@neukum.org>
References: <200707050858.03638.oliver@neukum.org>
	<200707082307.15616.rjw@sisk.pl>
	<E1I7pXr-0001Qn-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I7pXr-0001Qn-00@dorka.pomaz.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Montag, 9. Juli 2007 schrieb Miklos Szeredi:
> In that case the "we need suspend to be invisible to userspace" as a
> reason to use the freezer would also be moot, since if you don't
> schedule userspace after offlining the CPUs, it can't notice this.

After? Can you do the offlining atomically?

	Regards
		Oliver
