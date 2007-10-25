From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.24-rc1 regression] suspend fails
Date: Thu, 25 Oct 2007 22:44:50 +0200
Message-ID: <200710252244.50711.rjw@sisk.pl>
References: <200710252147.22814.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710252147.22814.arvidjaar@mail.ru>
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
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 25 October 2007 19:47, Andrey Borzenkov wrote:
> I can no more suspend with 2.6.24-rc1. 2.6.23 is fine. Here is kernel log; 
> config attached

Please try the patch from:
http://marc.info/?l=linux-mm-commits&m=119318609013090&w=2

Greetings,
Rafael
