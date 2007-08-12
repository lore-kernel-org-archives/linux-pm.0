From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: When to use a freezeable workqueue?
Date: Mon, 13 Aug 2007 00:18:38 +0200
Message-ID: <200708130018.38652.rjw__20505.2037993029$1186956570$gmane$org@sisk.pl>
References: <46BEC0AD.7080202@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46BEC0AD.7080202@s5r6.in-berlin.de>
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
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sunday, 12 August 2007 10:11, Stefan Richter wrote:
> In which situations is create_freezeable_workqueue() to be preferred
> over create_singlethread_workqueue()?
> 
> Is a freezable worqueue preferable whenever the worker thread /can/ be
> frozen, or is it only to be used if the thread /must/ be frozen during
> suspend?

The latter, IMO.

Generally, if you want it to be frozen.

Greetings,
Rafael
