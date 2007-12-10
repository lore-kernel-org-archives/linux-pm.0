From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH][RFC] freezer : add the TIF_FREEZE flag to
	all archs
Date: Mon, 10 Dec 2007 17:36:29 +0100
Message-ID: <200712101736.29676.rjw__11426.2211988263$1197303755$gmane$org@sisk.pl>
References: <47594F8C.7070900@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47594F8C.7070900@fr.ibm.com>
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
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: linux-arch@vger.kernel.org, Linux Containers <containers@lists.osdl.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, 7 of December 2007, Cedric Le Goater wrote:
> From: Cedric Le Goater <clg@fr.ibm.com>

Sorry for the delay, I somehow managed to overlook your message.

> This patch is the first step in making the refrigerator() available 
> to all architectures, even for those without power management. 
>
> The purpose of such a change is to be able to use the refrigerator() 
> in a new control group subsystem which will implement a control group
> freezer.

Hm, sounds interesting, but ...
 
> If you think this is safe and not utterly stupid, I'll send the rest
> of the patchset exporting the refrigerator to all arches.

... you will need to provide some details, I think.

I also think that it's safe to define TIF_FREEZE for all architectures, but
the usefulness of it will very much depend on the purpose. :-)

Greetings,
Rafael
