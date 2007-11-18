From: "=?utf-8?q?Rafa=C5=82_J=2E?= Wysocki" <rjwysocki@sisk.pl>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Sun, 18 Nov 2007 16:23:19 +0100
Message-ID: <200711181623.20029.rjwysocki__20949.2893809967$1195493061$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0711171649100.7748-100000@netrider.rowland.org>
	<200711181603.26522.rjw@sisk.pl> <474050EC.5080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <474050EC.5080507@gmail.com>
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
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 18 of November 2007, Jiri Slaby wrote:
> On 11/18/2007 04:03 PM, Rafael J. Wysocki wrote:
> > Can you also make the new System-map available, please?
> 
> Sure:
> http://www.fi.muni.cz/~xslaby/sklad/System.map1

The last notifier called in http://www.fi.muni.cz/~xslaby/sklad/susp_hang2.png
is apparently cpu_swap_callback() which is not called in
http://www.fi.muni.cz/~xslaby/sklad/susp_hang1.png .

Can you verify that cpu_swap_callback() gets called if the patch is not
applied?
