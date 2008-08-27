From: Oliver Neukum <oliver@neukum.org>
Subject: question on struct dvb_frontend_ops.sleep
Date: Wed, 27 Aug 2008 11:41:55 +0200
Message-ID: <200808271141.55546.oliver__16120.5643941232$1219830229$gmane$org@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-dvb@linuxtv.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

could somebody explain to me what the semantics of this call is?
It seems like dvbcore uses it to tell a device that it may power down.
But when is it to power up again? Is powering up implied in every
other method of the API? Can these methods sleep?

	Regards
		Oliver
